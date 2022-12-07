# simulate some data so you can test the script ====
set.seed(821)

## function to generate some random strings for labels
random_strings <- function(n = 5000) {
  a <- do.call(paste0, replicate(5, sample(LETTERS, n, TRUE), FALSE))
  paste0(a, sprintf("%04d", sample(9999, n, TRUE)), sample(LETTERS, n, TRUE))
}

## make master data frame
label <- random_strings(150)
outcome_group <- as.factor(rep(LETTERS[1:14], length.out = length(label)))
outcome_subgroup <- as.factor(rep(paste("Section label", 1:28, sep = " "), length.out = length(label)))
effect_estimate = rnorm(n = length(label), 0, 0.1)
standard_error <- effect_estimate/3
Pvalue = runif(n = length(label), min = 0, max = 0.1)
lower_confidence_interval <- effect_estimate - (1.96 * standard_error)
upper_confidence_interval <- effect_estimate + (1.96 * standard_error)
bars <- rnorm(length(label), 20, 2)
lines <- rnorm(length(label), 100, 20)

EpiViz_data <- data.frame(label, outcome_group, outcome_subgroup, effect_estimate,
                   standard_error, Pvalue, lower_confidence_interval, upper_confidence_interval,
                   bars, lines)
use_data(EpiViz_data, internal = FALSE, overwrite = TRUE)
