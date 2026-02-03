context("circos_plot function")

test_that("circos_plot runs without error on built-in data", {
    data("EpiViz_data1", package = "EpiViz")
    data("EpiViz_data2", package = "EpiViz")
    data("EpiViz_data3", package = "EpiViz")

    # Basic 1-track plot
    expect_error(
        circos_plot(
            track_number = 1,
            track1_data = EpiViz_data1,
            label_column = "label",
            section_column = "class",
            estimate_column = "beta",
            pvalue_column = "pvalue",
            lower_ci = "lower_confidence_interval",
            upper_ci = "upper_confidence_interval"
        ),
        NA
    )

    # 3-track plot with different types
    expect_error(
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
            legend_track = TRUE,
            track1_label = "T1",
            track2_label = "T2",
            track3_label = "T3"
        ),
        NA
    )
})

test_that("circos_plot handles equal_axis parameter", {
    data("EpiViz_data1", package = "EpiViz")
    data("EpiViz_data2", package = "EpiViz")

    expect_error(
        circos_plot(
            track_number = 2,
            track1_data = EpiViz_data1,
            track2_data = EpiViz_data2,
            label_column = "label",
            section_column = "class",
            estimate_column = "beta",
            pvalue_column = "pvalue",
            lower_ci = "lower_confidence_interval",
            upper_ci = "upper_confidence_interval",
            equal_axis = TRUE
        ),
        NA
    )
})
