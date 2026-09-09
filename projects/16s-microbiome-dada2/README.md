# 16S rRNA Microbiome Pipeline (DADA2)

**Group project** — completed as part of a class group assignment. Team members: Ebenezer Oppong Gyamfi, Joshua Ampofo Yentumi (add other teammates here if applicable).

Memory-efficient 16S rRNA amplicon pipeline on a mouse gut microbiome dataset, covering ASV inference through differential abundance testing.

## Structure
```
scripts/
  01_qc_filter_trim.Rmd        Package setup, read QC, filtering & trimming
  02_denoise_taxonomy.Rmd      Error learning, denoise/merge, chimera
                                removal, read tracking, taxonomy assignment
                                (SILVA v138.1)
  03_phyloseq_diversity.Rmd    Phyloseq object, alpha diversity, NMDS/
                                Bray-Curtis ordination, abundance barplots
  04_differential_abundance.Rmd  Differential abundance via DESeq2 and
                                  ANCOM-BC2, with cross-checking between
                                  the two methods
```
Run in numeric order — later stages depend on R objects created earlier in the pipeline.

## My contribution
_Add a line here describing specifically what you contributed to this group project — e.g. which sections you wrote, ran, or interpreted._

## Report
Full rendered report: [`/reports/16s-microbiome-dada2_report.pdf`](../../reports/16s-microbiome-dada2_report.pdf)

## Tools
R, DADA2, phyloseq, vegan, DESeq2, ANCOM-BC2
