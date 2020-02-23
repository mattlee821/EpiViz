# R package ====

# 1
svg("R_package/docs/images/1_track_example.svg", width = 30, height = 30, pointsize = 35)
circos_plot(track_number = 1, 
            track1_data = EpiViz::EpiViz_data1,
            track1_type = "points", 
            label_column = 1,
            section_column = 9, 
            estimate_column = 2, 
            pvalue_column = 3, 
            pvalue_adjustment = 1, 
            lower_ci = 4, 
            upper_ci = 5)
dev.off()

# 2
svg("R_package/docs/images/3track_type_example.svg", width = 30, height = 30, pointsize = 35)
circos_plot(track_number = 3,
            track1_data = EpiViz::EpiViz_data1,
            track2_data = EpiViz::EpiViz_data2,
            track3_data = EpiViz::EpiViz_data3,
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
            bar_column = 2)
dev.off()


# 3
svg("R_package/docs/images/legend_example.svg", width = 30, height = 30, pointsize = 35)
circos_plot(track_number = 3,
            track1_data = EpiViz::EpiViz_data1,
            track2_data = EpiViz::EpiViz_data2,
            track3_data = EpiViz::EpiViz_data3,
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
            legend = TRUE,
            track1_label = "Track 1",
            track2_label = "Track 2",
            track3_label = "Track 3",
            pvalue_label = "p-value <= 0.05",
            circle_size = 25)
dev.off()

# web application ====

# 1
svg("app/www/gallery/3_track_example.svg", width = 30, height = 30, pointsize = 35)
circos_plot(track_number = 3,
            track1_data = EpiViz::EpiViz_data1,
            track2_data = EpiViz::EpiViz_data2,
            track3_data = EpiViz::EpiViz_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = 1,
            section_column = 9,
            estimate_column = 2,
            pvalue_column = 3,
            pvalue_adjustment = 1,
            lower_ci = 4,
            upper_ci = 5)
dev.off()

# 3
svg("app/www/gallery/3_track_example_legend.svg", width = 30, height = 30, pointsize = 35)
circos_plot(track_number = 3,
            track1_data = EpiViz::EpiViz_data1,
            track2_data = EpiViz::EpiViz_data2,
            track3_data = EpiViz::EpiViz_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = 1,
            section_column = 9,
            estimate_column = 2,
            pvalue_column = 3,
            pvalue_adjustment = 1,
            lower_ci = 4,
            upper_ci = 5,
            legend = TRUE,
            track1_label = "Track 1",
            track2_label = "Track 2",
            track3_label = "Track 3",
            pvalue_label = "p-value <= 0.05",
            circle_size = 25)
dev.off()

