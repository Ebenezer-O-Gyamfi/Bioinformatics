#!/usr/bin/env bash
set -euo pipefail
REF="data/reference/ecoli_rel606.fasta"
TRIM_DIR="data/trimmed"
BAM_DIR="results/bam"
QC_DIR="results/statistics/alignment"
mkdir -p "$BAM_DIR" "$QC_DIR"

SUMMARY="${QC_DIR}/alignment_summary.tsv"
printf "sample\tgeneration\trun\ttotal_reads\tmapped_reads\tmapping_percent\tproperly_paired\tproperly_paired_percent\tmean_depth\tbreadth_1x_percent\tbreadth_10x_percent\n" > "$SUMMARY"

tail -n +2 metadata/samples.tsv |
while IFS=$'\t' read -r SAMPLE GENERATION RUN RAW_R1 RAW_R2; do
    R1="${TRIM_DIR}/${RUN}_1.trim.fastq.gz"
    R2="${TRIM_DIR}/${RUN}_2.trim.fastq.gz"
    BAM="${BAM_DIR}/${RUN}.aligned.sorted.bam"

    if [[ ! -s "$BAM" ]]; then
        bwa mem -t 4 -R "@RG\tID:${RUN}\tSM:${SAMPLE}\tPL:ILLUMINA" "$REF" "$R1" "$R2" |
        samtools sort -@ 4 -o "$BAM" -
    fi

    samtools quickcheck -v "$BAM"
    [[ -s "${BAM}.bai" ]] || samtools index -@ 4 "$BAM"
    samtools flagstat -@ 4 "$BAM" > "${QC_DIR}/${RUN}.flagstat.txt"
    samtools stats -@ 4 "$BAM" > "${QC_DIR}/${RUN}.samtools_stats.txt"
    samtools depth -aa "$BAM" > "${QC_DIR}/${RUN}.depth.txt"
done
