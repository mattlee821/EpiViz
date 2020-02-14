#' Simulated epidemiology data
#'
#' A simulated dataset of linear regression results for 123 outcomes.
#'
#' @format A simulated data frame with 123 rows and 8 variables imitating a traditional epidemiology results file from a linear regression:
#' \describe{
#'   \item{outcome_name}{The name of the outcomes}
#'   \item{outcome_group}{The groups which the outcomes can be put into}
#'   \item{outcome_subgroup}{Subgroups which the outcomes can be put into}
#'   \item{beta}{Effect estimates}
#'   \item{standard_error}{Standard errors of the effect estimates}
#'   \item{Pvalue}{Pvalues of the effec estimates and standard errors}
#'   \item{lower_confidence_interval}{Lower confidence interval bound}
#'   \item{upper_confidence_interval}{Upper confidence interval bound}
#'   ...
#' }
#' @source data-raw/example_data_simulation.R
"EpiViz_data"
