#-------------------------------------------------------------------

#Script: 03_merge_fasta.R

#Purpose: Merge all separate FASTA files into one containing all 4 FASTA sequences

#-------------------------------------------------------------------
# List FASTA files in the raw folder
fasta_files <- list.files("data/raw", pattern="\\.fasta$", full.names=TRUE)

combined_file <- "data/raw/sis1_orthologs.fasta"

# If combined file exists, delete it so we start fresh
if (file.exists(combined_file)) {
  file.remove(combined_file)
}

# Loop through each FASTA file and append it to the merged file
for (f in fasta_files) {
  txt <- readLines(f, warn = FALSE)
  
  # Open a connection in append mode
  con <- file(combined_file, open = "a")
  writeLines(txt, con, sep = "\n", useBytes = TRUE)
  close(con)
}

cat("Merged FASTA created at:", combined_file, "\n")
