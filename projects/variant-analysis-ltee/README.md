# Variant Analysis — LTEE Ara-3 Population

Whole-genome resequencing variant-calling and annotation pipeline applied to three samples from the *E. coli* Long-Term Evolution Experiment (LTEE), population Ara-3, processed against the ancestral REL606 reference genome.

| Sample | Generation | SRA run |
|---|---:|---|
| Ara3_5000 | 5,000 | SRR2589044 |
| Ara3_15000 | 15,000 | SRR2584863 |
| Ara3_50000 | 50,000 | SRR2584866 |

## Pipeline
1. Raw read download and QC
2. Adapter/quality trimming and post-trim QC
3. Reference genome preparation and alignment
4. Variant calling and functional annotation
5. Downstream analysis in R: VCF parsing, variant-count summaries, mutation-spectrum analysis, and annotated high-impact/biologically flagged variant tables (including DNA-repair and citrate-related genes, relevant to LTEE's known Cit+ phenotype evolution)

## Report
Full rendered report: [`/reports/variant-analysis-ltee_report.pdf`](../../reports/variant-analysis-ltee_report.pdf)

## Tools
Shell pipeline (QC/trimming/alignment/variant-calling tools), R for downstream VCF analysis and visualization
