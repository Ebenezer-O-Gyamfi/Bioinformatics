# 16S rRNA Microbiome Pipeline (DADA2)

**Group project** — completed as part of a class group assignment. Team members: Ebenezer Oppong Gyamfi, Joshua Ampofo Yentumi (add other teammates here if applicable).

Memory-efficient 16S rRNA amplicon pipeline on a mouse gut microbiome dataset, covering ASV inference through differential abundance testing.

## Workflow
1. Read quality inspection, filtering, and trimming
2. Error-rate learning, denoising, and merging (DADA2)
3. Sequence table construction and chimera removal
4. Taxonomy assignment (SILVA v138.1 reference database)
5. `phyloseq` object construction and exploration
6. Alpha diversity, NMDS/Bray-Curtis ordination, and abundance barplots
7. Differential abundance analysis (DESeq2 and ANCOM-BC2), with cross-checking between the two methods

## My contribution
_Add a line here describing specifically what you contributed to this group project — e.g. which sections you wrote, ran, or interpreted._

## Report
Full rendered report: [`/reports/16s-microbiome-dada2_report.pdf`](../../reports/16s-microbiome-dada2_report.pdf)

## Tools
R, DADA2, phyloseq, vegan, DESeq2, ANCOM-BC2
