#!/usr/bin/env bash

set -euo pipefail
VCF_DIR="results/vcf"; OUT_DIR="results/annotation"; STATS_DIR="results/statistics/annotation"
mkdir -p "$OUT_DIR" "$STATS_DIR"

tail -n +2 metadata/samples.tsv |
while IFS=$'\t' read -r SAMPLE GENERATION RUN R1 R2; do
    INPUT="${VCF_DIR}/${RUN}.PASS.norm.vcf.gz"
    OUTPUT="${OUT_DIR}/${RUN}.annotated.vcf.gz"

    snpEff -c snpeff/snpEff.config -v \
        -stats "${STATS_DIR}/${RUN}.snpeff_summary.html" \
        -csvStats "${STATS_DIR}/${RUN}.snpeff_stats.csv" \
        REL606 "$INPUT" | bgzip -c > "$OUTPUT"

    tabix -p vcf "$OUTPUT"
done
