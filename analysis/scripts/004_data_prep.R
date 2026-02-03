rm(list=ls())
## set environment ====
library(dplyr)
library(fuzzyjoin)

# data ====
load("analysis/data/ng_anno.rda")
mr_results <- read.table("analysis/results/mr_results.txt", header = T, sep = "\t")
harmonise_data <- read.table("analysis/results/harmonise_data.txt", header = T, sep = "\t")
# metab <- read.table("analysis/data/metabolite_labels.txt", header = T, sep = "\t")

# join harmonise data to metablite labels ====
data <- unique(harmonise_data[,c("id.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)
data$originalname.outcome <- gsub(r"{\s*\([^\)]+\)}","", as.character(data$originalname.outcome))
ng_anno$originalname.outcome <- gsub(r"{\s*\([^\)]+\)}","", as.character(ng_anno$raw.label))

# recode some spellings 
ng_anno[ng_anno == "Estimated description of fatty acid chain length, not actual carbon number"] <- "Description of average fatty acid chain length, not actual carbon number"

# combined
a <- left_join(data, ng_anno, by = "originalname.outcome")
a_no <- a[rowSums(is.na(a)) > 0,]
data_joined <- a[complete.cases(a), ]

a <- a_no[,1:2]
a <- left_join(a, ng_anno, by = c("originalname.outcome" = "label.no.units"))
a_no <- a[rowSums(is.na(a)) > 0,]
a <- a[complete.cases(a), ]
a <- a[,c(1:7,9,8)]
colnames(a)[8] <- "label.no.units"
data_joined <- rbind(data_joined, a)

a <- a_no[,1:2]
head(a,16)

# manually add info for non-joiners ====
a_no <- a_no[,1:2]

a <- data.frame(
  
  id.outcome = a_no$id.outcome,
  
  originalname.outcome = a_no$originalname.outcome,
  
  metabolite = NA,
  raw.label = NA,

  class = c(
    "Metabolites ratio",
    "Fatty acids",
    "Metabolites ratio",
    "Fatty acids",
    "Fatty acids",
    "Metabolites ratio",
    "Fatty acids",
    "Protein",
    "Fatty acids",
    "Fatty acids",
    "Amino acids",
    "Fatty acids",
    "Fatty acids",
    "Fatty acids",
    "Fatty acids"
    ),
  
  subclass = c(
    "Metabolites ratio",
    "Fatty acids",
    "Metabolites ratio",
    "Fatty acids",
    "Fatty acids",
    "Metabolites ratio",
    "Fatty acids",
    "Protein",
    "Fatty acids",
    "Fatty acids",
    "Amino acids",
    "Fatty acids",
    "Fatty acids",
    "Fatty acids",
    "Fatty acids"
    ),
  
  label = NA,
  label.no.units = a_no$originalname.outcome,
    
  derived_features = c(
    "yes",
    "yes",
    "yes",
    "yes",
    "yes",
    "yes",
    "yes",
    "no",
    "no",
    "no",
    "no",
    "yes",
    "yes",
    "yes",
    "yes"
  )
  )
data_joined <- rbind(data_joined, a)

# combined with mr_results ====
data <- left_join(mr_results, data_joined, by = "id.outcome")

# format adiposity labels ====
table(data$exposure)
data$sex[data$exposure == "bmi.giant-ukbb.meta-analysis.combined.23May2018.txt_pulit_snps.txt"] <- "Sex-combined"
data$sex[data$exposure == "whr.giant-ukbb.meta-analysis.combined.23May2018.txt_pulit_snps.txt"] <- "Sex-combined"
data$sex[data$exposure == "whradjbmi.giant-ukbb.meta-analysis.combined.23May2018.txt_pulit_snps.txt"] <- "Sex-combined"

data$sex[data$exposure == "bmi.giant-ukbb.meta-analysis.males.23May2018.txt_pulit_snps.txt"] <- "Male"
data$sex[data$exposure == "whr.giant-ukbb.meta-analysis.males.23May2018.txt_pulit_snps.txt"] <- "Male"
data$sex[data$exposure == "whradjbmi.giant-ukbb.meta-analysis.males.23May2018.txt_pulit_snps.txt"] <- "Male"

data$sex[data$exposure == "bmi.giant-ukbb.meta-analysis.females.23May2018.txt_pulit_snps.txt"] <- "Female"
data$sex[data$exposure == "whr.giant-ukbb.meta-analysis.females.23May2018.txt_pulit_snps.txt"] <- "Female"
data$sex[data$exposure == "whradjbmi.giant-ukbb.meta-analysis.females.23May2018.txt_pulit_snps.txt"] <- "Female"

## exposures
data$exposure[data$exposure == "bmi.giant-ukbb.meta-analysis.combined.23May2018.txt_pulit_snps.txt"] <- "BMI"
data$exposure[data$exposure == "bmi.giant-ukbb.meta-analysis.males.23May2018.txt_pulit_snps.txt"] <- "BMI"
data$exposure[data$exposure == "bmi.giant-ukbb.meta-analysis.females.23May2018.txt_pulit_snps.txt"] <- "BMI"

data$exposure[data$exposure == "whr.giant-ukbb.meta-analysis.combined.23May2018.txt_pulit_snps.txt"] <- "WHR"
data$exposure[data$exposure == "whr.giant-ukbb.meta-analysis.males.23May2018.txt_pulit_snps.txt"] <- "WHR"
data$exposure[data$exposure == "whr.giant-ukbb.meta-analysis.females.23May2018.txt_pulit_snps.txt"] <- "WHR"

data$exposure[data$exposure == "whradjbmi.giant-ukbb.meta-analysis.combined.23May2018.txt_pulit_snps.txt"] <- "WHRadjBMI"
data$exposure[data$exposure == "whradjbmi.giant-ukbb.meta-analysis.males.23May2018.txt_pulit_snps.txt"] <- "WHRadjBMI"
data$exposure[data$exposure == "whradjbmi.giant-ukbb.meta-analysis.females.23May2018.txt_pulit_snps.txt"] <- "WHRadjBMI"

## calculate confidence intervals ====
data$lower_ci <- data$b - (1.96 * data$se)
data$upper_ci <- data$b + (1.96 * data$se)

## save final data frame ====
write.table(data, "analysis/results/mr_results_formatted.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# make example files ====
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data <- data[,c("exposure", "originalname.outcome", "class", "subclass", "b", "lower_ci", "upper_ci", "pval", "sex")]
colnames(data) <- c("exposure", "label", "group1", "group2", "effect_estimate", "lower_ci", "upper_ci", "pvalue", "sex")

bmi <- subset(data, exposure == "BMI")
whr <- subset(data, exposure == "WHR")

bmi_combined <- subset(bmi, sex == "Sex-combined")
bmi_combined <- select(bmi_combined, !sex)
write.table(bmi_combined, "analysis/results/bmi_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
whr_combined <- subset(whr, sex == "Sex-combined")
whr_combined <- select(whr_combined, !sex)
write.table(whr_combined, "analysis/results/whr_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

bmi_male <- subset(bmi, sex == "Male")
bmi_male <- select(bmi_male, !sex)
write.table(bmi_male, "analysis/results/bmi_male.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
whr_male <- subset(whr, sex == "Male")
whr_male <- select(whr_male, !sex)
write.table(whr_male, "analysis/results/whr_male.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

bmi_female <- subset(bmi, sex == "Female")
bmi_female <- select(bmi_female, !sex)
write.table(bmi_female, "analysis/results/bmi_female.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
whr_female <- subset(whr, sex == "Female")
whr_female <- select(whr_female, !sex)
write.table(whr_female, "analysis/results/whr_female.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

