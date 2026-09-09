# TCGA-BRCA RNA-Seq Data Mining

Independent project analyzing TCGA Breast Invasive Carcinoma (BRCA) RNA-seq Level 3 mRNA expression data (RSEM output, Broad GDAC Firehose pipeline) — 878 samples, ~20,500 initial gene identifiers.

## Structure
```
notebooks/
  01_data_mining_preprocessing.Rmd   Cleaning, exploration, PCA
  02_clustering_classification.Rmd   Clustering & classification (continues from 01)
```

### `01_data_mining_preprocessing.Rmd`
- Barcode recovery and sample-group derivation (tumor / normal / metastatic) from TCGA barcodes
- Noise removal: CPM-based low-expression filtering, IQR winsorizing, outlier-sample flagging
- Missing-value handling (removal vs. median imputation by missingness threshold)
- Descriptive statistics and visualization of the most variable genes
- log2 and per-gene z-score transformation
- Feature selection (top 2,000 genes by coefficient of variation)
- Principal Component Analysis (PCA) and sample proximity analysis (Euclidean distance, Pearson correlation heatmaps)

### `02_clustering_classification.Rmd`
Continues from `01` using the 10-PC feature matrix.
- Unsupervised clustering: k-means (k = 2–8, silhouette-selected) and hierarchical clustering, compared against known tissue groups
- Supervised classification (tumor vs. normal): ridge-penalized logistic regression, random forest, and SVM (RBF kernel)
- Model evaluation: confusion matrices, ROC curves, performance comparison across models

## Report
Full rendered reports: [`/reports/tcga-brca_data-mining_preprocessing_report.pdf`](../../reports/tcga-brca_data-mining_preprocessing_report.pdf) and [`/reports/tcga-brca_clustering-classification_report.pdf`](../../reports/tcga-brca_clustering-classification_report.pdf)

## Tools
R, dplyr, tidyr, ggplot2, pheatmap, reshape2
