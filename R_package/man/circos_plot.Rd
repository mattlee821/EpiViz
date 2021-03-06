% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/circos_plot.R
\name{circos_plot}
\alias{circos_plot}
\title{Create a Circos plot with up to 3 tracks using points, lines or bars}
\usage{
circos_plot(
  track_number,
  track1_data,
  track2_data,
  track3_data,
  track1_type,
  track2_type,
  track3_type,
  label_column,
  section_column,
  order = TRUE,
  order_column,
  estimate_column,
  pvalue_column,
  pvalue_adjustment,
  lower_ci,
  upper_ci,
  lines_column,
  lines_type = "o",
  bar_column,
  histogram_column,
  histogram_binsize = 0.01,
  histogram_densityplot = FALSE,
  legend = FALSE,
  track1_label = NA,
  track2_label = NA,
  track3_label = NA,
  pvalue_label = NA,
  circle_size = 25,
  track1_height = 0.2,
  track2_height = 0.2,
  track3_height = 0.2,
  equal_axis = FALSE
)
}
\arguments{
\item{track_number}{The number of tracks you wnat your circos plot to have. Maximum number of tracks is 3.}

\item{track1_data}{The data frame of your first track.}

\item{track2_data}{The data frame of your second track.}

\item{track3_data}{The data frame of your third track.}

\item{track1_type}{The type of plot for the first track. One of "scatter", "lines", "bar" and "histogram".}

\item{track2_type}{The type of plot for the second track. One of "scatter", "lines", "bar" and "histogram".}

\item{track3_type}{The type of plot for the third track. One of "scatter", "lines", "bar" and "histogram".}

\item{label_column}{The column in your data frames that you will use as the labels for the circos plot. This will likely be the column with your exposure/outcome name in. Labels go on the outside of the plot.}

\item{section_column}{The column in your data frames that you will use to group/section your data/plot by.}

\item{order}{Do you want MR Viz to organise your columns alphabetically. Default is TRUE}

\item{order_column}{If order = FALSE what column do you want to order your sections by}

\item{estimate_column}{The column in your data frames with the estimates in.}

\item{pvalue_column}{The column in your data frames with the p-values in.}

\item{pvalue_adjustment}{The threshold you want to set your p-value 'significance' threshold too. This can be in the format of a single value or a function e.g. 0.05/22. The p-value thrshold is only used for scatter plots.}

\item{lower_ci}{The column in your data frames with the lower confidence intervals in.}

\item{upper_ci}{The column in your data frames with the upper confidence intervals in.}

\item{lines_column}{The column in your data frames that you want to plot as lines.}

\item{lines_type}{The type of line plot you want. "l" = straight lines; "o" = straight lines with points; "s" = boxed lines; "h" = vertical lines. Default is "o".}

\item{bar_column}{The column in your data frames that you want to plot as bars.}

\item{histogram_column}{The column in your data frames that you want to plot as histograms.}

\item{histogram_binsize}{The binsize of the histogram. Default is 0.01.}

\item{histogram_densityplot}{Do you want your histogram to be a density plot or not. Default is FALSE.}

\item{legend}{Do you want a legend = TRUE or FALSE. FALSE by default}

\item{track1_label}{What do you want the label for the first track to be e.g. "Body Mass Index"}

\item{track2_label}{What do you want the label for the first track to be e.g. "Corondary Heart Disease"}

\item{track3_label}{What do you want the label for the first track to be e.g. "Breast Cancer"}

\item{pvalue_label}{What do you want the label for the p-value to read e.g. "p-value <= 0.05"}

\item{circle_size}{The size of the circos plot. Smaller numbers make larger circos plots. Default is 25. You will need to adjust this number a few times to get the perfect size for your specific circos plot requirements. If you have long labels then try ≥ 25. If your labels are short try 1-10.}

\item{track1_height}{Size of the track as a percent of the whole circle. Default is 20 percent (0.20)}

\item{track2_height}{Size of the track as a percent of the whole circle. Default is 20 percent (0.20)}

\item{track3_height}{Size of the track as a percent of the whole circle. Default is 20 percent (0.20). It is sometimes worth increasing the size of track 3 to 30 percent}

\item{equal_axis}{Do you want your tracks to share the same axis (Defalut = FALSE), if TRUE it will use the minimmum and maximum from the upper and lower confidence intervals to calculate the axis for each track. This ONLY applies to 'points' all other plot types are independent of each track.}
}
\description{
Create a Circos plot with up to 3 tracks using points, lines or bars
}
\examples{
circos_plot(track_number = 3,
track1_data = EpiViz_data1,
track2_data = EpiViz_data2,
track3_data = EpiViz_data3,
track1_type = "points",
track2_type = "lines",
track3_type = "bar",
label_column = 1,
section_column = 9,
estimate_column = 2,
pvalue_column = 3,
pvalue_adjustment = 1,
lower_ci = 4,
upper_ci = 5,
lines_column = 2,
lines_type = "o",
bar_column = 2,
legend = FALSE,
circle_size = 25)

}
