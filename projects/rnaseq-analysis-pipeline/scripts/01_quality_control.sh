#!/usr/bin/env bash
set -euo pipefail

METADATA="metadata/SRP144496_metadata.tsv"
RAW_DIR="raw_data"
FASTQC_DIR="results/01_raw_fastqc"
MULTIQC_DIR="results/02_raw_multiqc"
THREADS=4
MAX_DOWNLOAD_ATTEMPTS=3

mkdir -p "$RAW_DIR" "$FASTQC_DIR" "$MULTIQC_DIR" logs

# --- dependency check ------------------------------------------------------
for PROGRAM in awk wget gzip stat fastqc multiqc; do
  command -v "$PROGRAM" >/dev/null 2>&1 || { echo "Missing: $PROGRAM"; exit 1; }
done

# --- validate / recover every FASTQ listed in the metadata table -----------
validate_fastq() {
  local file="$1" expected_size="$2"
  [[ -s "$file" ]] || return 1
  [[ "$(stat -c%s "$file")" -eq "$expected_size" ]] || return 1
  gzip -t "$file" 2>/dev/null || return 1
  return 0
}

RUN_COL=$(head -1 "$METADATA"  | tr '\t' '\n' | nl -ba | awk '$2=="run_accession"{print $1}')
FTP_COL=$(head -1 "$METADATA"  | tr '\t' '\n' | nl -ba | awk '$2=="fastq_ftp"{print $1}')
BYTE_COL=$(head -1 "$METADATA" | tr '\t' '\n' | nl -ba | awk '$2=="fastq_bytes"{print $1}')

while IFS=$'\t' read -r RUN URL EXPECTED_SIZE; do
  FASTQ="${RAW_DIR}/${RUN}.fastq.gz"
  if validate_fastq "$FASTQ" "$EXPECTED_SIZE"; then continue; fi

  [[ "$URL" == http* || "$URL" == ftp* ]] || URL="https://${URL}"
  for ((attempt=1; attempt<=MAX_DOWNLOAD_ATTEMPTS; attempt++)); do
    rm -f "$FASTQ"
    wget --tries=5 --timeout=60 --continue -O "$FASTQ" "$URL" && break
    sleep 3
  done
  validate_fastq "$FASTQ" "$EXPECTED_SIZE" || { echo "FAILED: $RUN"; exit 1; }
done < <(awk -F'\t' -v r="$RUN_COL" -v f="$FTP_COL" -v b="$BYTE_COL" \
            'NR>1 {print $r"\t"$f"\t"$b}' "$METADATA")


# --- QC ----------------------------------------------------------------
fastqc --threads "$THREADS" --outdir "$FASTQC_DIR" "$RAW_DIR"/*.fastq.gz

multiqc "$FASTQC_DIR" \
  --outdir "$MULTIQC_DIR" \
  --filename SRP144496_raw_multiqc.html \
  --force
