# Differential Expression Analysis with DESeq2

**Group project** — completed as part of a class group assignment. Team members: Ebenezer Oppong Gyamfi, Andrews Adu (add other teammates here if applicable).

Differential gene expression analysis on an RNA-seq count dataset (plant infection time-course: mock vs. *Pseudomonas syringae* DC3000 infection, sampled at multiple days post-inoculation), using DESeq2.

## Contents
- `06_differential_analysis.Rmd` — analysis notebook
- `raw_counts.csv` — gene-level raw count matrix
- `samples_to_conditions.csv` — sample metadata (growth condition, infection status, days post-inoculation)

## Workflow
1. Build `DESeqDataSet` and apply pre-filtering (≥10 reads in ≥3 samples)
2. Run DESeq2 differential expression modelling
3. Extract and filter the differential gene table by FDR threshold
4. Visualize results: volcano plot, MA plots, and multiple heatmap variants (raw, z-score scaled, clustered, and sample-subset views)

## My contribution
_Add a line here describing specifically what you contributed to this group project — e.g. which sections you wrote, ran, or interpreted._

## Tools
R, DESeq2, tidyverse, pheatmap, EnhancedVolcano
