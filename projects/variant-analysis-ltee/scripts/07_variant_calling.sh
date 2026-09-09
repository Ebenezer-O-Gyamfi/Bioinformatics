#!/usr/bin/env bash
set -euo pipefail
REF="data/reference/ecoli_rel606.fasta"
BAM_DIR="results/bam"; BCF_DIR="results/bcf"; VCF_DIR="results/vcf"
mkdir -p "$BCF_DIR" "$VCF_DIR"

tail -n +2 metadata/samples.tsv |
while IFS=$'\t' read -r SAMPLE GENERATION RUN R1 R2; do
    BAM="${BAM_DIR}/${RUN}.aligned.sorted.bam"
    RAW_BCF="${BCF_DIR}/${RUN}.raw.bcf"
    RAW_VCF="${VCF_DIR}/${RUN}.raw.vcf.gz"
    FILTERED_VCF="${VCF_DIR}/${RUN}.filtered.vcf.gz"

    bcftools mpileup --threads 4 -Ou -f "$REF" -a FORMAT/AD,FORMAT/DP "$BAM" |
        bcftools view -Ob -o "$RAW_BCF"

    bcftools call --threads 4 --ploidy 1 -m -v -Oz -o "$RAW_VCF" "$RAW_BCF"
    bcftools index -t "$RAW_VCF"

    bcftools filter --threads 4 -e 'QUAL<20 || FORMAT/DP<10' -s LowQual -Oz -o "$FILTERED_VCF" "$RAW_VCF"
    bcftools index -t "$FILTERED_VCF"

    bcftools stats "$FILTERED_VCF" > "results/statistics/variants/${RUN}.bcftools_stats.txt"
done
