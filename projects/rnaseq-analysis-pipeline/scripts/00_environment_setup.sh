#!/usr/bin/env bash
# Command-line tools (conda/mamba, bioconda channel)
mamba create -n srp144496 -c bioconda -c conda-forge \
  fastqc multiqc hisat2 samtools subread wget gzip awk r-base
conda activate srp144496

# R / Bioconductor packages
Rscript -e 'if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
             BiocManager::install(c("DESeq2", "ggplot2", "pheatmap", "ggrepel"))'
