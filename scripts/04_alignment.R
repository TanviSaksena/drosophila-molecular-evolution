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

cat("Reading combined FASTA file...\n")

seqs <- readAAStringSet("data/raw/sis1_orthologs.fasta")
print(seqs)

cat("Running multiple sequence alignment using ClustalOmega...\n")

alignment <- msa(seqs, method = "ClustalOmega")

cat("Alignment completed.\n")

# Convert alignment (optional but good practice)
aln <- msaConvert(alignment, type = "seqinr::alignment")

if (!dir.exists("results/alignment")) {
  dir.create("results/alignment", recursive = TRUE)
}

cat("Saving pretty alignment to FASTA text...\n")

# Save alignment as FASTA
writeXStringSet(
  msaConvert(alignment, type = "Biostrings::AAStringSet"),
  file = "results/alignment/Sis1_alignment.fasta"
)

# Save alignment as plain text
capture.output(
  print(alignment, show = "complete"),
  file = "results/alignment/Sis1_alignment.txt"
)

cat("Alignment saved as FASTA and TXT.\n")


