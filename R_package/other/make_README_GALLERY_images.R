# load simulated data so you can test the script ====
library(devtools)
devtools::install_github("mattlee821/EpiCircos", force = TRUE)
library(EpiCircos)

# 1 track example ====
svg("docs/images/1_track_example.svg",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 1,
            track1_data = EpiCircos::EpiCircos_data,
            track1_type = "points",
            label_column = 1,
            section_column = 2,
            estimate_column = 4,
            pvalue_column = 5,
            pvalue_adjustment = 0.05,
            lower_ci = 7,
            upper_ci = 8)
dev.off()

# 3 track / different type of track example ====
svg("docs/images/3track_type_example.svg",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = EpiCircos::EpiCircos_data,
            track2_data = EpiCircos::EpiCircos_data,
            track3_data = EpiCircos::EpiCircos_data,
            track1_type = "points",
            track2_type = "lines",
            track3_type = "bar",
            label_column = 1,
            section_column = 2,
            estimate_column = 4,
            pvalue_column = 5,
            pvalue_adjustment = 0.05,
            lower_ci = 7,
            upper_ci = 8,
            lines_column = 10,
            lines_type = "o",
            bar_column = 9,
            circle_size = 25)
dev.off()

# png example
png("docs/images/png_example.png")
circos_plot(track_number = 3,
            track1_data = EpiCircos::EpiCircos_data,
            track2_data = EpiCircos::EpiCircos_data,
            track3_data = EpiCircos::EpiCircos_data,
            track1_type = "points",
            track2_type = "lines",
            track3_type = "bar",
            label_column = 1,
            section_column = 2,
            estimate_column = 4,
            pvalue_column = 5,
            pvalue_adjustment = 0.05,
            lower_ci = 7,
            upper_ci = 8,
            lines_column = 10,
            lines_type = "o",
            bar_column = 9)
dev.off()


# legend example ====
svg("docs/images/legend_example.svg",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = EpiCircos::EpiCircos_data,
            track2_data = EpiCircos::EpiCircos_data,
            track3_data = EpiCircos::EpiCircos_data,
            track1_type = "points",
            track2_type = "lines",
            track3_type = "bar",
            label_column = 1,
            section_column = 2,
            estimate_column = 4,
            pvalue_column = 5,
            pvalue_adjustment = 0.05,
            lower_ci = 7,
            upper_ci = 8,
            lines_column = 10,
            lines_type = "o",
            bar_column = 9,
            legend = TRUE,
            track1_label = "Track 1",
            track2_label = "Track 2",
            track3_label = "Track 3",
            pvalue_label = "<= 0.05",
            circle_size = 25)
dev.off()
