#-------------------------------------------------------------------

#Script: 02_get_sequences.R

#Purpose: Download Sis1/DnaJ1 orthologs protein sequences from UniProt

#-------------------------------------------------------------------
library(httr)

#List of UniProt IDs for known orthologs:
accessions<-c(
  "P25294", #Yeast Sis1
  "Q24133", #Drosophila DnaJ-1
  "P25685", #Human DNAJB1
  "Q9QYJ3" #Mouse Dnajb1
)


if (!dir.exists("data/raw")) dir.create("data/raw", recursive = TRUE)

for (acc in accessions) {
  url <- paste0("https://rest.uniprot.org/uniprotkb/", acc, ".fasta")
  dest <- paste0("data/raw/", acc, ".fasta")
  
  cat("Downloading:", acc, "\n")
  
  resp <- GET(url)
  
  if (status_code(resp) == 200) {
    writeBin(content(resp, "raw"), dest)
    cat("Saved:", dest, "\n\n")
  } else {
    cat("Failed to download", acc, "- status:", status_code(resp), "\n\n")
  }
}


