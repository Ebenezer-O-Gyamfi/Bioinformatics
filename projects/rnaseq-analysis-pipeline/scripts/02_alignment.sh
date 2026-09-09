#!/usr/bin/env bash
set -euo pipefail

THREADS="${THREADS:-8}"
GENCODE_VERSION=50
RAW_DIR="raw_data"
REF_DIR="reference_genome/gencode_v${GENCODE_VERSION}"
INDEX_PREFIX="${REF_DIR}/hisat2_index/GRCh38"
ALIGN_DIR="results/03_alignment"
MULTIQC_DIR="results/04_alignment_multiqc"

GENOME="${REF_DIR}/GRCh38.primary_assembly.genome.fa"
GTF="${REF_DIR}/gencode.v${GENCODE_VERSION}.primary_assembly.annotation.gtf"
SPLICE_SITES="${REF_DIR}/gencode.v${GENCODE_VERSION}.splicesites.txt"

GENOME_URL="https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_${GENCODE_VERSION}/GRCh38.primary_assembly.genome.fa.gz"
GTF_URL="https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_${GENCODE_VERSION}/gencode.v${GENCODE_VERSION}.primary_assembly.annotation.gtf.gz"

mkdir -p "$REF_DIR" "$(dirname "$INDEX_PREFIX")" "$ALIGN_DIR" "$MULTIQC_DIR" logs

# --- dependency check ------------------------------------------------------
for PROGRAM in hisat2 hisat2-build hisat2_extract_splice_sites.py samtools wget gzip awk multiqc; do
  command -v "$PROGRAM" >/dev/null 2>&1 || { echo "Missing: $PROGRAM"; exit 1; }
done

# --- reference genome + annotation -----------------------------------------
[[ -s "$GENOME" ]] || { wget -O "${GENOME}.gz" "$GENOME_URL"; gzip -dc "${GENOME}.gz" > "$GENOME"; }
[[ -s "$GTF" ]]    || { wget -O "${GTF}.gz"    "$GTF_URL";    gzip -dc "${GTF}.gz"    > "$GTF"; }
[[ -s "$SPLICE_SITES" ]] || hisat2_extract_splice_sites.py "$GTF" > "$SPLICE_SITES"

# --- HISAT2 index (built once, reused across all samples) ------------------
if ! ls "${INDEX_PREFIX}".*.ht2 >/dev/null 2>&1; then
  hisat2-build -p "$THREADS" "$GENOME" "$INDEX_PREFIX"
fi

# --- align every sample ------------------------------------------------
for FASTQ in "$RAW_DIR"/*.fastq.gz; do
  RUN=$(basename "$FASTQ" .fastq.gz)
  SAMPLE_DIR="${ALIGN_DIR}/${RUN}"
  mkdir -p "$SAMPLE_DIR"
  BAM="${SAMPLE_DIR}/${RUN}.sorted.bam"

  hisat2 -p "$THREADS" -x "$INDEX_PREFIX" -U "$FASTQ" \
    --known-splicesite-infile "$SPLICE_SITES" \
    --summary-file "${SAMPLE_DIR}/${RUN}_hisat2_summary.txt" \
    --new-summary \
  | samtools sort -@ 2 -o "$BAM" -

  samtools index -@ 2 "$BAM"
  samtools flagstat -@ 2 "$BAM" > "${SAMPLE_DIR}/${RUN}_flagstat.txt"
done

multiqc "$ALIGN_DIR" \
  --outdir "$MULTIQC_DIR" \
  --filename SRP144496_alignment_multiqc_report.html \
  --force
