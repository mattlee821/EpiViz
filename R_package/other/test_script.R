devtools::install_github("mattlee821/EpiCircos")
library(EpiCircos)

pdf("test2.pdf",
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
     lines_column = 4,
     lines_type = "o",
     bar_column = 4,
     histogram_column = 4,
     histogram_binsize = 0.01,
     histogram_densityplot = F,
     legend = TRUE,
     track1_label = "track 1",
     track2_label = "track 2",
     track3_label = "track 3",
     pvalue_label = "p-value <= 0.05",
     circle_size = 25)
dev.off()



track_number = 3
track1_data = EpiCircos_data
track2_data = EpiCircos_data
track3_data = EpiCircos_data
track1_type = "points"
track2_type = "lines"
track3_type = "bar"
label_column = 1
section_column = 2
estimate_column = 4
pvalue_column = 5
pvalue_adjustment = 0.05
lower_ci = 7
upper_ci = 8
lines_column = 4
lines_type = "o"
bar_column = 4
histogram_column = 4
histogram_binsize = 0.01
histogram_densityplot = F
circle_size = 25



















