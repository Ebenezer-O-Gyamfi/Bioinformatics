#!/usr/bin/env bash
set -euo pipefail
mkdir -p results/fastqc_trimmed results/multiqc/trimmed
fastqc --threads 4 --outdir results/fastqc_trimmed data/trimmed/*.trim.fastq.gz
multiqc results/fastqc_trimmed --outdir results/multiqc/trimmed --force
