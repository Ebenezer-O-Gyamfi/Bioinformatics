#!/usr/bin/env bash
set -euo pipefail

THREADS="${THREADS:-6}"
STRAND_MODE=2
GTF="reference_genome/gencode_v50/gencode.v50.primary_assembly.annotation.gtf"
ALIGN_DIR="results/03_alignment"
COUNT_DIR="results/06_quantification"
MULTIQC_DIR="results/07_quantification_multiqc"
COUNTS="${COUNT_DIR}/SRP144496_featureCounts.txt"
MATRIX="${COUNT_DIR}/SRP144496_gene_counts.tsv"

mkdir -p "$COUNT_DIR" "$MULTIQC_DIR" logs

BAMS=( "$ALIGN_DIR"/*/*.sorted.bam )
[[ "${#BAMS[@]}" -eq 16 ]] || { echo "Expected 16 BAMs, found ${#BAMS[@]}"; exit 1; }

featureCounts -T "$THREADS" -s "$STRAND_MODE" -t exon -g gene_id \
  -a "$GTF" -o "$COUNTS" "${BAMS[@]}"


# --- clean, DESeq2-ready count matrix (drop featureCounts metadata cols) --
awk '
  BEGIN { FS=OFS="\t" }
  NR==1 && /^#/ { next }
  $1=="Geneid" {
    printf "gene_id"
    for (i=7;i<=NF;i++){ s=$i; sub(/^.*\//,"",s); sub(/\.sorted\.bam$/,"",s); printf OFS s }
    printf "\n"; next
  }
  { printf $1; for (i=7;i<=NF;i++) printf OFS $i; printf "\n" }
' "$COUNTS" > "$MATRIX"

multiqc "$COUNT_DIR" \
  --outdir "$MULTIQC_DIR" \
  --filename SRP144496_quantification_multiqc.html \
  --force
