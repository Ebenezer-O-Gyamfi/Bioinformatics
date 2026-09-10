#!/usr/bin/env bash

set -euo pipefail
REF_DIR="data/reference"
REF="${REF_DIR}/ecoli_rel606.fasta"
REF_URL="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/017/985/GCA_000017985.1_ASM1798v1/GCA_000017985.1_ASM1798v1_genomic.fna.gz"
mkdir -p "$REF_DIR" results/statistics/reference

if [[ ! -s "$REF" ]]; then
    curl --fail --location --retry 5 --retry-delay 5 --output "${REF}.gz" "$REF_URL"
    gunzip "${REF}.gz"
fi

seqkit stats "$REF" > results/statistics/reference/REL606_seqkit_stats.txt
[[ -f "${REF}.bwt" ]] || bwa index "$REF"
[[ -f "${REF}.fai" ]] || samtools faidx "$REF"
