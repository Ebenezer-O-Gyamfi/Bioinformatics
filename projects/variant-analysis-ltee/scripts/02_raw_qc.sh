#!/usr/bin/env bash
set -euo pipefail
mkdir -p results/fastqc_raw results/multiqc/raw
fastqc --threads 4 --outdir results/fastqc_raw data/raw/*.fastq.gz
multiqc results/fastqc_raw --outdir results/multiqc/raw --force
