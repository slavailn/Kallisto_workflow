library(edgeR)
# Here, we will use edgeR's readDGE function to create
# tables of estimates counts and transcript per million values
# produced by kallisto

setwd("/path/to/wd")
setwd("kallisto_abundances/")

list.files()
# "M62_abundance.tsv"  
# "M7_abundance.tsv"   
# "M8_abundance.tsv"

# Examine one of the abundance files
abund <- read.table("M3_abundance.tsv", sep = "\t", header = T,
                    blank = T, quote = "\"")
head(abund)[1:3,]
# est_counts: Column 4
# tpm: Column 5

# Create a matrix of estimated counts
files <- list.files()[grep("tsv", list.files())]
est_counts <- readDGE(files, columns = c(1, 4))
est_counts <- est_counts$counts
head(est_counts)[1:2,][,1:3]
write.csv(est_counts, file = "estimated_counts.csv")

tpm <- readDGE(files, columns = c(1, 5))
tpm <- tpm$counts
tpm[1:4,][,1:4]
write.csv(tpm, file = "tpm.csv")


