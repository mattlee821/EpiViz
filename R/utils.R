#' Internal helper to prepare data for circos plotting
#' @noRd
prep_epiviz_data <- function(data, section_column, label_column, order = TRUE, order_column = NULL) {
    if (is.null(data) || nrow(data) == 0) {
        return(NULL)
    }

    # Safety check for empty column indices
    if (length(section_column) == 0 || length(label_column) == 0) {
        return(NULL)
    }

    # 1. organize the data based on section and alphabetically within that based on label
    if (order == TRUE) {
        data <- data[order(data[[section_column]], data[[label_column]]), ]
    } else {
        if (!is.null(order_column)) {
            data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
        }
        data <- data[order(data[[section_column]], data[[label_column]]), ]
    }

    # 2. add column of positions within each section (1:n)
    data$x_pos <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN = seq_along))

    # 3. Standardize x axis to 0-1 within each section (ncat)
    # This avoids the nested loop in the original getaxis function
    section_counts <- table(data[[section_column]])
    data$n_in_section <- as.numeric(section_counts[as.character(data[[section_column]])])
    data$ncat <- data$x_pos / data$n_in_section

    # 4. add column that codes sections as numbers for factors
    data$section_numbers <- factor(data[[section_column]],
        labels = 1:nlevels(as.factor(data[[section_column]]))
    )

    return(data)
}

#' Internal helper to calculate axis limits
#' @noRd
get_track_limits <- function(data, lower_col = NULL, upper_col = NULL, value_col = NULL, padding = 0.1) {
    if (is.null(data) || nrow(data) == 0) {
        return(c(0, 1))
    }

    if (!is.null(lower_col) && !is.null(upper_col) && length(lower_col) > 0 && length(upper_col) > 0) {
        vals <- c(data[[lower_col]], data[[upper_col]])
    } else if (!is.null(value_col) && length(value_col) > 0) {
        vals <- data[[value_col]]
    } else {
        return(c(0, 1))
    }


    axis_min <- min(vals, na.rm = TRUE)
    axis_max <- max(vals, na.rm = TRUE)

    # Add some padding
    range_val <- axis_max - axis_min
    if (range_val == 0) range_val <- 1

    axis_min <- round(axis_min - (range_val * padding), 3)
    axis_max <- round(axis_max + (range_val * padding), 3)

    return(c(axis_min, axis_max))
}
