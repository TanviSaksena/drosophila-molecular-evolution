# ===============================

# Script: 04_alignment.R

# Purpose: Multiple Sequence Alignment of Sis1 / DNAJB1 orthologs

# ===============================

# install packages (Install once, load everytime)
#install.packages("BiocManager")
#BiocManager::install("msa")
#install.packages("tinytex")
#tinytex::install_tinytex()

# Load libraries
library(msa)
library(Biostrings)
#########################################

#install.packages("bio3d")
library(bio3d)

# Create output directory if needed
if (!dir.exists("results/alignment")) {
  dir.create("results/alignment", recursive = TRUE)
}

# Convert aligned matrix to FASTA lines
fasta_lines <- c()

for (i in seq_len(nrow(aln_fasta$ali))) {
  header <- paste0(">", aln_fasta$id[i])
  seq <- paste(aln_fasta$ali[i, ], collapse = "")
  fasta_lines <- c(fasta_lines, header, seq)
}

# Write aligned FASTA file
writeLines(fasta_lines, "results/alignment/Sis1_alignment.fasta")

# Save readable alignment
capture.output(
  print(alignment, show = "complete"),
  file = "results/alignment/Sis1_alignment.txt"
)

cat("✔ Alignment saved successfully\n")
