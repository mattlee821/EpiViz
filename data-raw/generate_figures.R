# Generate figures for package documentation
library(devtools)
devtools::load_all(".")

# Ensure the directories exist
if (!dir.exists("man/figures")) dir.create("man/figures", recursive = TRUE)
if (!dir.exists("vignettes/figures")) dir.create("vignettes/figures", recursive = TRUE)

# Data for plotting
data("EpiViz_data1")
data("EpiViz_data2")
data("EpiViz_data3")

# Common settings
res <- 300
width <- 12
height <- 12

# 1. Basic 3-track Points Plot
svg("man/figures/3_track_points.svg", width = width, height = height)
circos_plot(
    track_number = 3,
    track1_data = EpiViz_data1,
    track2_data = EpiViz_data2,
    track3_data = EpiViz_data3,
    track1_type = "points",
    track2_type = "points",
    track3_type = "points",
    label_column = "label",
    section_column = "class",
    estimate_column = "beta",
    pvalue_column = "pvalue",
    lower_ci = "lower_confidence_interval",
    upper_ci = "upper_confidence_interval",
    circle_size = 25
)
dev.off()

# 2. 3-track Points Plot with Equal Axis
svg("man/figures/3_track_points_equal.svg", width = width, height = height)
circos_plot(
    track_number = 3,
    track1_data = EpiViz_data1,
    track2_data = EpiViz_data2,
    track3_data = EpiViz_data3,
    track1_type = "points",
    track2_type = "points",
    track3_type = "points",
    label_column = "label",
    section_column = "class",
    estimate_column = "beta",
    pvalue_column = "pvalue",
    lower_ci = "lower_confidence_interval",
    upper_ci = "upper_confidence_interval",
    equal_axis = TRUE,
    circle_size = 25
)
dev.off()

# 3. Mixed Tracks (Points, Lines, Bars)
svg("man/figures/mixed_tracks.svg", width = width, height = height)
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
    circle_size = 25
)
dev.off()

# 4. Mixed Tracks with Legend
svg("man/figures/mixed_tracks_legend.svg", width = width, height = height)
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
    legend_track = 0.05,
    track1_label = "Points",
    track2_label = "Lines",
    track3_label = "Bars",
    pvalue_label = "P < 0.05",
    circle_size = 25
)
dev.off()

# 5. Legend Complex (Tracks and Sections)
svg("man/figures/legend_complex.svg", width = width, height = height)
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
    legend_track = 0.08,
    legend_section = 0.03,
    track1_label = "Points",
    track2_label = "Lines",
    track3_label = "Bars",
    pvalue_label = "P < 0.05",
    circle_size = 25
)
dev.off()

# Copy to vignettes/figures
file.copy(list.files("man/figures", full.names = TRUE), "vignettes/figures", overwrite = TRUE)
