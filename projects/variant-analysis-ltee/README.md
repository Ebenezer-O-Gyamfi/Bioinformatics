# Variant Analysis — LTEE Ara-3 Population

Whole-genome resequencing variant-calling and annotation pipeline applied to three samples from the *E. coli* Long-Term Evolution Experiment (LTEE), population Ara-3, processed against the ancestral REL606 reference genome.

| Sample | Generation | SRA run |
|---|---:|---|
| Ara3_5000 | 5,000 | SRR2589044 |
| Ara3_15000 | 15,000 | SRR2584863 |
| Ara3_50000 | 50,000 | SRR2584866 |


## Structure
```
scripts/                     Shell pipeline (run in numeric order)
  01_download.sh              Download raw reads
  02_raw_qc.sh                Raw-read QC (FastQC/MultiQC)
  03_trim.sh                  Adapter/quality trimming
  04_trimmed_qc.sh            Post-trim QC
  05_prepare_reference.sh     Reference genome preparation
  06_align.sh                 Alignment to REL606
  07_variant_calling.sh       Variant calling
  10_annotate_variants.sh     Functional annotation
metadata/samples.tsv         Sample-to-generation-to-SRA-run mapping
downstream_analysis.Rmd      R analysis: VCF parsing, variant-count and
                              mutation-spectrum summaries, annotated
                              high-impact/DNA-repair/citrate-gene variant
                              tables
```
Raw sequencing data, reference indexes, BAMs, and VCFs are not included due to size — see the full rendered report for all figures and tables.

## Report
Full rendered report: [`/reports/variant-analysis-ltee_report.pdf`](../../reports/variant-analysis-ltee_report.pdf)

## Tools
FastQC, MultiQC, Trimmomatic, BWA/SAMtools, a variant caller, snpEff-style annotation, R (vcfR, tidyverse) for downstream analysis
