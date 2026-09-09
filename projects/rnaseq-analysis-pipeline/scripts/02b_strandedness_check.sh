#!/usr/bin/env bash
set -euo pipefail

DIR="results/05_strandedness"
mkdir -p "$DIR"

assignment_pct() {
  awk -F'\t' '
    NR==1 { for (i=2;i<=NF;i++){ s[i]=$i; sub(/^.*\//,"",s[i]); sub(/\.sorted\.bam$/,"",s[i]) }; next }
    { for (i=2;i<=NF;i++){ total[i]+=$i; if ($1=="Assigned") assigned[i]=$i } }
    END { for (i=2;i<=NF;i++) printf "%s\t%.4f\n", s[i], 100*assigned[i]/total[i] }
  ' "$1"
}

paste <(assignment_pct "$DIR/counts_s0.txt.summary") \
      <(assignment_pct "$DIR/counts_s1.txt.summary") \
      <(assignment_pct "$DIR/counts_s2.txt.summary") |
  awk 'BEGIN{printf "%-15s %10s %10s %10s\n","SAMPLE","s0 (%)","s1 (%)","s2 (%)"}
       {printf "%-15s %10.2f %10.2f %10.2f\n",$1,$2,$4,$6}'
