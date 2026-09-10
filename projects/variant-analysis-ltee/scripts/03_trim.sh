#!/usr/bin/env bash

set -euo pipefail
TRIM_DIR="data/trimmed"
UNPAIRED_DIR="${TRIM_DIR}/unpaired"
STATS_DIR="results/statistics/trimming"
mkdir -p "$TRIM_DIR" "$UNPAIRED_DIR" "$STATS_DIR"

ADAPTERS=$(find "$CONDA_PREFIX" -type f -name "NexteraPE-PE.fa" 2>/dev/null | head -n 1)

tail -n +2 metadata/samples.tsv |
while IFS=$'\t' read -r SAMPLE GENERATION RUN R1 R2; do
    OUT_R1="${TRIM_DIR}/${RUN}_1.trim.fastq.gz"
    OUT_R2="${TRIM_DIR}/${RUN}_2.trim.fastq.gz"
    OUT_U1="${UNPAIRED_DIR}/${RUN}_1.unpaired.fastq.gz"
    OUT_U2="${UNPAIRED_DIR}/${RUN}_2.unpaired.fastq.gz"
    SUMMARY="${STATS_DIR}/${RUN}.trimmomatic_summary.txt"

    if [[ -s "$OUT_R1" && -s "$OUT_R2" ]]; then
        echo "[SKIP] Trimmed paired reads already exist for $RUN"
    else
        trimmomatic PE -threads 4 -phred33 -summary "$SUMMARY" \
            "$R1" "$R2" "$OUT_R1" "$OUT_U1" "$OUT_R2" "$OUT_U2" \
            ILLUMINACLIP:"${ADAPTERS}":2:40:15 \
            SLIDINGWINDOW:4:20 \
            MINLEN:25
    fi
done

seqkit stats "$TRIM_DIR"/*.trim.fastq.gz > "$STATS_DIR/trimmed_seqkit_stats.txt"
