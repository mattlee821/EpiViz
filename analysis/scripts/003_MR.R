rm(list=ls())
# MR analysis of measures of adiposity and endometrial cancer 

# environment ====
## library ====
#remotes::install_github("MRCIEU/TwoSampleMR")
library(TwoSampleMR)
library(data.table)
library(RadialMR)
library(dplyr)
library(tidyverse)

### methods
methods <- mr_method_list()
methods_heterogeneity <- subset(methods, heterogeneity_test == TRUE)$obj
methods_heterogeneity <- methods_heterogeneity[c(1,2,3,5)]
methods <- methods[c(3,6,10,13),1]

### colours
#install.packages("wesanderson")
library(wesanderson)
d1 <- wes_palette("Royal1", type = "discrete")
d2 <- wes_palette("GrandBudapest2", type = "discrete")
d3 <- wes_palette("Cavalcanti1", type = "discrete")
d4 <- wes_palette("Rushmore1", type = "discrete")
discrete_wes_pal <- c(d1, d2, d3, d4)
rm(d1,d2,d3,d4)

## extract exposure instruments ====
exposure_data <- read_exposure_data("analysis/data/000_clumped_pulit.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "beta.exposure",
                                    se_col = "se.exposure",
                                    eaf_col = "eaf.exposure",
                                    effect_allele_col = "effect_allele.exposure",
                                    other_allele_col = "other_allele.exposure",
                                    pval_col = "pval.exposure",
                                    samplesize_col = "samplesize.exposure",
                                    phenotype = "exposure",
                                    min_pval = 5e-9)

exposure_data$exposure <- as.factor(exposure_data$exposure)
exposure_data$f_stats <- (exposure_data$b / exposure_data$se)^2 
exposure_data %>%
  group_by(exposure) %>%
  summarise(mean = mean(f_stats))

write.table(exposure_data, "analysis/results/exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## extract outcome data ====
metabs <- available_outcomes()[grepl("met-c", available_outcomes()$id), ][[1]]
outcome_data  <- extract_outcome_data(snps = exposure_data$SNP, 
                                      outcomes = metabs, 
                                      proxies = 1, 
                                      rsq = 0.8, 
                                      align_alleles = 1, 
                                      palindromes = 1, 
                                      maf_threshold = 0.3)
write.table(outcome_data, "analysis/results/outcome_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## harmonize data ====
harmonise_data <- harmonise_data(exposure_data, outcome_data, action = 2)
write.table(harmonise_data, "analysis/results/harmonise_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## MR ====
mr_results <- mr(harmonise_data, method_list = methods)
write.table(mr_results, "analysis/results/mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## Sensitivity analysis ====
mr_singlesnp <- mr_singlesnp(harmonise_data)
write.table(mr_singlesnp, "analysis/results/mr_singlesnp.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

mr_hetrogeneity <- mr_heterogeneity(harmonise_data, method_list = methods_heterogeneity)
write.table(mr_hetrogeneity, "analysis/results/mr_hetrogeneity.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

mr_pleiotropy <- mr_pleiotropy_test(harmonise_data)
write.table(mr_pleiotropy, "analysis/results/mr_pleiotropy.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

mr_leaveoneout <- mr_leaveoneout(harmonise_data)
write.table(mr_leaveoneout, "analysis/results/mr_leaveoneout.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## Plots ====
source("analysis/scripts/my_mr_scatter_plot.R")
plot_mr_scatter <- my_mr_scatter_plot(mr_results, harmonise_data)

plot_singlesnp_forest <- mr_forest_plot(mr_singlesnp)

plot_leaveoneout_forest <- mr_leaveoneout_plot(mr_leaveoneout)

plot_mr_funnel <- mr_funnel_plot(mr_singlesnp)

### save plots ====
pdf("analysis/results/plot_mr_scatter.pdf")
for (i in 1:length(plot_mr_scatter)) {
  print(plot_mr_scatter[[i]])
}
dev.off()

pdf("analysis/results/plot_singlesnp_forest.pdf")
for (i in 1:length(plot_singlesnp_forest)) {
  print(plot_singlesnp_forest[[i]])
}
dev.off()

pdf("analysis/results/plot_leaveoneout_forest.pdf")
for (i in 1:length(plot_leaveoneout_forest)) {
  print(plot_leaveoneout_forest[[i]])
}
dev.off()

pdf("analysis/results/plot_mr_funnel.pdf")
for (i in 1:length(plot_mr_funnel)) {
  print(plot_mr_funnel[[i]])
}
dev.off()
