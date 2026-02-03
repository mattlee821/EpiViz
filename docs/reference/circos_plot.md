# Create a Circos plot with up to 3 tracks using points, lines or bars

Create a Circos plot with up to 3 tracks using points, lines or bars

## Usage

``` r
circos_plot(
  track_number,
  track1_data,
  track2_data = NULL,
  track3_data = NULL,
  track1_type = "points",
  track2_type = "points",
  track3_type = "points",
  label_column,
  section_column,
  order = TRUE,
  order_column = NULL,
  estimate_column = NULL,
  pvalue_column = NULL,
  pvalue_adjustment = 0.05,
  lower_ci = NULL,
  upper_ci = NULL,
  lines_column = NULL,
  lines_type = "o",
  bar_column = NULL,
  histogram_column = NULL,
  histogram_binsize = 0.01,
  histogram_densityplot = FALSE,
  legend_track = FALSE,
  legend_section = FALSE,
  track1_label = NA,
  track2_label = NA,
  track3_label = NA,
  pvalue_label = NA,
  circle_size = 25,
  track1_height = 0.2,
  track2_height = 0.2,
  track3_height = 0.2,
  equal_axis = FALSE,
  origin = 0,
  colours = c("#00378f", "#ffc067", "#894300")
)
```

## Arguments

- track_number:

  The number of tracks you wnat your circos plot to have. Maximum number
  of tracks is 3.

- track1_data:

  The data frame of your first track.

- track2_data:

  The data frame of your second track.

- track3_data:

  The data frame of your third track.

- track1_type:

  The type of plot for the first track. One of "scatter", "lines", "bar"
  and "histogram".

- track2_type:

  The type of plot for the second track. One of "scatter", "lines",
  "bar" and "histogram".

- track3_type:

  The type of plot for the third track. One of "scatter", "lines", "bar"
  and "histogram".

- label_column:

  The column in your data frames that you will use as the labels for the
  circos plot. This will likely be the column with your exposure/outcome
  name in. Labels go on the outside of the plot.

- section_column:

  The column in your data frames that you will use to group/section your
  data/plot by.

- order:

  Do you want MR Viz to organise your columns alphabetically. Default is
  TRUE

- order_column:

  If order = FALSE what column do you want to order your sections by

- estimate_column:

  The column in your data frames with the estimates in.

- pvalue_column:

  The column in your data frames with the p-values in.

- pvalue_adjustment:

  The threshold you want to set your p-value 'significance' threshold
  too. This can be in the format of a single value or a function e.g.
  0.05/22. The p-value thrshold is only used for scatter plots.

- lower_ci:

  The column in your data frames with the lower confidence intervals in.

- upper_ci:

  The column in your data frames with the upper confidence intervals in.

- lines_column:

  The column in your data frames that you want to plot as lines.

- lines_type:

  The type of line plot you want. "l" = straight lines; "o" = straight
  lines with points; "s" = boxed lines; "h" = vertical lines. Default is
  "o".

- bar_column:

  The column in your data frames that you want to plot as bars.

- histogram_column:

  The column in your data frames that you want to plot as histograms.

- histogram_binsize:

  The binsize of the histogram. Default is 0.01.

- histogram_densityplot:

  Do you want your histogram to be a density plot or not. Default is
  FALSE.

- legend_track:

  Track legend control. Set to FALSE for no legend (default), or provide
  a numeric value (0-1) representing the distance from the bottom of the
  plot (NPC units). Default when TRUE is 0.05. The legend is centered
  horizontally and items are arranged in a horizontal row.

- legend_section:

  Section legend control. Set to FALSE for no legend (default), or
  provide a numeric value (0-1) representing the distance from the
  bottom of the plot (NPC units). The section legend creates a numbered
  key for the categories defined in section_column.

- track1_label:

  What do you want the label for the first track to be e.g. "Body Mass
  Index"

- track2_label:

  What do you want the label for the first track to be e.g. "Corondary
  Heart Disease"

- track3_label:

  What do you want the label for the first track to be e.g. "Breast
  Cancer"

- pvalue_label:

  What do you want the label for the p-value to read e.g. "p-value \<=
  0.05"

- circle_size:

  The size of the circos plot. Smaller numbers make larger circos plots.
  Default is 25. You will need to adjust this number a few times to get
  the perfect size for your specific circos plot requirements. If you
  have long labels then try ≥ 25. If your labels are short try 1-10.

- track1_height:

  Size of the track as a percent of the whole circle. Default is 20
  percent (0.20)

- track2_height:

  Size of the track as a percent of the whole circle. Default is 20
  percent (0.20)

- track3_height:

  Size of the track as a percent of the whole circle. Default is 20
  percent (0.20). It is sometimes worth increasing the size of track 3
  to 30 percent

- equal_axis:

  Do you want your tracks to share the same axis (Defalut = FALSE), if
  TRUE it will use the minimmum and maximum from the upper and lower
  confidence intervals to calculate the axis for each track. This ONLY
  applies to 'points' all other plot types are independent of each
  track.

- origin:

  Where do you want your X axis line drawn, e.g. 0 for continuous
  outcomes and 1 for binary outcomes when using beta and odds ratios
  respectively. Default is 0

- colours:

  list of colours for each track. Use "".
