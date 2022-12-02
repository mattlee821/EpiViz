# clump instruments
rm(list=ls())

# environment ====
## library ====
remotes::install_github("MRCIEU/TwoSampleMR")
library(TwoSampleMR)
library(dplyr)

# read data
filenames <- list.files(path = "analysis/data/", pattern="txt_pulit_snps.txt", full.names=F)
list <- lapply(paste0("analysis/data/",filenames), read.table, header = T)

# format and save ====
for (i in 1:length(filenames)){
  list[[i]]$adiposity <- filenames[i]
}
data <- bind_rows(list, .id = "column_label")
data <- data[,-1]
data$rsID <- gsub(":.*", "", data$SNP)
write.table(data, "analysis/data/000_unclumped_pulit.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

colnames(data) <- c("CHR","POS","SNPID",
  "effect_allele.exposure","other_allele.exposure","eaf.exposure", 
  "beta.exposure", "se.exposure", "pval.exposure", "samplesize.exposure",
  "INFO", "exposure", "SNP")

data$id.exposure <- data$exposure

data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)

write.table(data, "analysis/data/000_clumped_pulit.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
