context("Utility functions")

test_that("prep_epiviz_data correctly prepares data", {
    # Load built-in data
    # Note: In tests, we might need to load it explicitly or it might be available if package is loaded
    data("EpiViz_data1", package = "EpiViz")

    # Test with default ordering
    prepared <- prep_epiviz_data(EpiViz_data1, section_column = "class", label_column = "label")

    expect_true(!is.null(prepared))
    expect_true("x_pos" %in% names(prepared))
    expect_true("ncat" %in% names(prepared))
    expect_true("section_numbers" %in% names(prepared))
    expect_s3_class(prepared$section_numbers, "factor")

    # Check if ncat is simplified correctly (should be between 0 and 1)
    expect_true(all(prepared$ncat > 0 & prepared$ncat <= 1))
})

test_that("get_track_limits returns reasonable values", {
    df <- data.frame(
        low = c(1, 2, 3),
        high = c(4, 5, 6),
        val = c(2, 3, 4)
    )

    # Test with lower/upper
    lims <- get_track_limits(df, lower_col = "low", upper_col = "high")
    expect_length(lims, 2)
    expect_true(lims[1] < 1)
    expect_true(lims[2] > 6)

    # Test with single value column
    lims_val <- get_track_limits(df, value_col = "val")
    expect_length(lims_val, 2)
    expect_true(lims_val[1] < 2)
    expect_true(lims_val[2] > 4)
})

test_that("prep_epiviz_data handles safety checks", {
    expect_null(prep_epiviz_data(NULL, "a", "b"))
    expect_null(prep_epiviz_data(data.frame(a = 1), character(0), "b"))
})
