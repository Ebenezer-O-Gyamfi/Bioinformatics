# RNA-Seq Analysis Pipeline

An end-to-end, reproducible RNA-seq workflow, documented as a single R Markdown file combining shell-based upstream processing with an executable R-based differential expression stage.

## Pipeline stages
1. **Raw read QC** — FastQC / MultiQC
2. **Reference indexing & alignment** — HISAT2 (splice-aware), SAMtools; includes library-strandedness verification
3. **Gene-level quantification** — featureCounts
4. **Differential expression analysis** — DESeq2 in R, executed directly in the document: model fitting, PCA and sample-correlation diagnostics, dispersion plots, per-contrast MA plots, volcano plots, and top-50 DEG heatmaps

Stages 1–3 depend on multi-gigabyte raw sequencing files and a full GRCh38/GENCODE reference build, so they are documented as shell chunks; Stage 4 runs directly on the resulting gene-count matrix and regenerates all tables/figures on knit.

## Report
Full rendered report: [`/reports/rnaseq-analysis-pipeline_report.pdf`](../../reports/rnaseq-analysis-pipeline_report.pdf)

## Tools
FastQC, MultiQC, HISAT2, SAMtools, featureCounts, R, DESeq2
