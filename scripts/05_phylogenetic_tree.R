# ===============================
# Script: 05_phylogenetic_tree.R
# Purpose: Build phylogenetic tree from aligned DNAJB1/Sis1 proteins
# ===============================

library(Biostrings)
library(ape)

aa <- readAAStringSet("results/alignment/Sis1_alignment.fasta")

# VERY IMPORTANT: clean names
names(aa) <- c("Yeast", "Drosophila", "Human", "Mouse")

# Convert AAStringSet → character matrix
aa_char <- as.matrix(aa)

# Convert matrix → AAbin
aa_bin <- as.AAbin(aa_char)

##VALIDATION##

class(aa_bin)
# should be: "AAbin"

is.matrix(aa_bin)
# TRUE

dim(aa_bin)
# 4 x 363

########
dist_mat <- dist.aa(aa_bin, pairwise.deletion = TRUE)

tree <- nj(dist_mat)

#for rooted tree
tree_rooted <- root(tree, outgroup = "Yeast", resolve.root = TRUE)
plot(tree_rooted, main = "DNAJB1/SIS1 rooted phylogeny", cex = 1)

