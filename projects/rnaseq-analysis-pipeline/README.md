# RNA-Seq Analysis Pipeline — SRP144496

An end-to-end RNA-seq workflow: QC, splice-aware alignment, gene-level quantification, and differential expression, applied to the SRP144496 dataset (HT55 and SW948 cell lines, itraconazole vs. control).


## Structure
```
scripts/
  00_environment_setup.sh      Conda/mamba environment (fastqc, multiqc,
                                hisat2, samtools, subread)
  01_quality_control.sh        Raw-read QC (FastQC/MultiQC)
  02_alignment.sh               HISAT2 splice-aware alignment (GENCODE v50)
  02b_strandedness_check.sh     Library strandedness verification
  03_quantification.sh          Gene-level quantification (featureCounts)
04_differential_expression.Rmd  Stage 4: DESeq2 model fitting, PCA and
                                 sample-correlation diagnostics, dispersion
                                 plots, per-cell-line contrasts (HT55,
                                 SW948), MA plots, volcano plots, and
                                 top-50 DEG heatmaps
```
Raw FASTQ files, the reference genome index, and BAM files are not included due to size — see the full rendered report for all figures and tables.

## Report
Full rendered report: [`/reports/rnaseq-analysis-pipeline_report.pdf`](../../reports/rnaseq-analysis-pipeline_report.pdf)

## Tools
FastQC, MultiQC, HISAT2, SAMtools, featureCounts, R, DESeq2
