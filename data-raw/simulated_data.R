# General simulated data for EpiViz package
set.seed(821)

# Function to generate random strings for labels with varying lengths (5 to 20)
random_strings <- function(n = 150) {
    sapply(seq_len(n), function(x) {
        len <- sample(5:20, 1)
        paste0(sample(c(LETTERS, 0:9), len, replace = TRUE), collapse = "")
    })
}

# Shared structural columns
n_total <- 120
labels <- random_strings(n_total)

# Create uneven groups/subgroups by sampling
group_names <- paste("Group", LETTERS[1:6])
subgroup_names <- paste("Subgroup", 1:12)

# Sample with replacement to get uneven distribution
groups <- sample(group_names, n_total, replace = TRUE)
# Ensure subgroups are somewhat nested or just distributed
subgroups <- sample(subgroup_names, n_total, replace = TRUE)

# Sort them to keep them together in the simulation
structural_df <- data.frame(groups, subgroups)
structural_df <- structural_df[order(structural_df$groups, structural_df$subgroups), ]

groups <- structural_df$groups
subgroups <- structural_df$subgroups

# Function to generate data frame with structural columns + random values
generate_data <- function(label_vec, group_vec, subgroup_vec) {
    n <- length(label_vec)
    beta <- rnorm(n, 0, 0.1)
    se <- abs(rnorm(n, 0.05, 0.01))
    pvalue <- 2 * pnorm(-abs(beta / se))

    data.frame(
        label = label_vec,
        class = group_vec,
        subgroup = subgroup_vec,
        beta = beta,
        se = se,
        pvalue = pvalue,
        lower_confidence_interval = beta - (1.96 * se),
        upper_confidence_interval = beta + (1.96 * se)
    )
}

# Generate 3 datasets
EpiViz_data1 <- generate_data(labels, groups, subgroups)
EpiViz_data2 <- generate_data(labels, groups, subgroups)
EpiViz_data3 <- generate_data(labels, groups, subgroups)

# Save to data/
usethis::use_data(EpiViz_data1, overwrite = TRUE)
usethis::use_data(EpiViz_data2, overwrite = TRUE)
usethis::use_data(EpiViz_data3, overwrite = TRUE)
