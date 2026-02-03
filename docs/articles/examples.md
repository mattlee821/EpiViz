# R Package Examples

## Getting Started with the EpiViz R Package

The `EpiViz` package provides a high-level wrapper around `circlize` and
`ComplexHeatmap` to make creating circular plots for epidemiological
data straightforward.

``` r

library(EpiViz)
```

### Basic 1-Track Plot

The simplest plot involves a single track showing point estimates and
confidence intervals.

``` r

# Using built-in example data
circos_plot(
    track_number = 1,
    track1_data = EpiViz_data1,
    track1_type = "points",
    label_column = "label",
    section_column = "class",
    estimate_column = "beta",
    pvalue_column = "pvalue",
    lower_ci = "lower_confidence_interval",
    upper_ci = "upper_confidence_interval",
    circle_size = 25
)
```

### Complex 3-Track Plot

You can combine different plot types across up to 3 tracks. This is
useful for comparing multiple exposures or outcome sets.

``` r

circos_plot(
    track_number = 3,
    track1_data = EpiViz_data1,
    track2_data = EpiViz_data2,
    track3_data = EpiViz_data3,
    track1_type = "points",
    track2_type = "lines",
    track3_type = "bar",
    label_column = "label",
    section_column = "class",
    estimate_column = "beta",
    pvalue_column = "pvalue",
    lower_ci = "lower_confidence_interval",
    upper_ci = "upper_confidence_interval",
    lines_column = "beta",
    bar_column = "beta",
    legend = TRUE,
    track1_label = "BMI Combined",
    track2_label = "BMI Male",
    track3_label = "BMI Female"
)
```

### Customizing the Layout

#### Ordering Sections

By default, sections are ordered alphabetically. You can use an
`order_column` to define a custom sequence.

``` r

circos_plot(
    track_number = 1,
    track1_data = EpiViz_data1,
    label_column = "label",
    section_column = "class",
    order = FALSE,
    order_column = "subclass" # Or any numeric column
)
```

#### Shared Axis Limits

When comparing tracks, use `equal_axis = TRUE` to force all tracks to
share the same Y-axis scale.

``` r

circos_plot(
    track_number = 3,
    track1_data = EpiViz_data1,
    track2_data = EpiViz_data2,
    track3_data = EpiViz_data3,
    equal_axis = TRUE,
    ...
)
```
