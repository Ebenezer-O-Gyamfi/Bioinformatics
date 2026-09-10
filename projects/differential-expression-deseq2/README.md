# Differential Expression Analysis with DESeq2

Differential gene expression analysis on an RNA-seq count dataset (plant infection time-course: mock vs. *Pseudomonas syringae* DC3000 infection, sampled at multiple days post-inoculation), using DESeq2.

## Structure
```
notebooks/06_differential_analysis.Rmd   Analysis notebook
data/raw_counts.csv                      Gene-level raw count matrix
data/samples_to_conditions.csv           Sample metadata (growth, infection, dpi)
```

## Workflow
1. Build `DESeqDataSet` and apply pre-filtering (≥10 reads in ≥3 samples)
2. Run DESeq2 differential expression modelling
3. Extract and filter the differential gene table by FDR threshold
4. Visualize results: volcano plot, MA plots, and multiple heatmap variants (raw, z-score scaled, clustered, and sample-subset views)


## Tools
R, DESeq2, tidyverse, pheatmap, EnhancedVolcano
