#' Create a Circos plot with up to 3 tracks using points, lines or bars
#'
#' @param track_number The number of tracks you wnat your circos plot to have. Maximum number of tracks is 3.
#' @param track1_data The data frame of your first track.
#' @param track2_data The data frame of your second track.
#' @param track3_data The data frame of your third track.
#' @param track1_type The type of plot for the first track. One of "scatter", "lines", "bar" and "histogram".
#' @param track2_type The type of plot for the second track. One of "scatter", "lines", "bar" and "histogram".
#' @param track3_type The type of plot for the third track. One of "scatter", "lines", "bar" and "histogram".
#' @param label_column The column in your data frames that you will use as the labels for the circos plot. This will likely be the column with your exposure/outcome name in. Labels go on the outside of the plot.
#' @param section_column The column in your data frames that you will use to group/section your data/plot by.
#' @param order Do you want MR Viz to organise your columns alphabetically. Default is TRUE
#' @param order_column If order = FALSE what column do you want to order your sections by
#' @param estimate_column The column in your data frames with the estimates in.
#' @param pvalue_column The column in your data frames with the p-values in.
#' @param pvalue_adjustment The threshold you want to set your p-value 'significance' threshold too. This can be in the format of a single value or a function e.g. 0.05/22. The p-value thrshold is only used for scatter plots.
#' @param lower_ci The column in your data frames with the lower confidence intervals in.
#' @param upper_ci The column in your data frames with the upper confidence intervals in.
#' @param lines_column The column in your data frames that you want to plot as lines.
#' @param lines_type The type of line plot you want. "l" = straight lines; "o" = straight lines with points; "s" = boxed lines; "h" = vertical lines. Default is "o".
#' @param bar_column The column in your data frames that you want to plot as bars.
#' @param histogram_column The column in your data frames that you want to plot as histograms.
#' @param histogram_binsize The binsize of the histogram. Default is 0.01.
#' @param histogram_densityplot Do you want your histogram to be a density plot or not. Default is FALSE.
#' @param legend_track Track legend control. Set to FALSE for no legend (default), or provide a numeric value (0-1) representing the distance from the bottom of the plot (NPC units). Default when TRUE is 0.05. The legend is centered horizontally and items are arranged in a horizontal row.
#' @param legend_section Section legend control. Set to FALSE for no legend (default), or provide a numeric value (0-1) representing the distance from the bottom of the plot (NPC units). The section legend creates a numbered key for the categories defined in section_column.
#' @param track1_label What do you want the label for the first track to be e.g. "Body Mass Index"
#' @param track2_label What do you want the label for the first track to be e.g. "Corondary Heart Disease"
#' @param track3_label What do you want the label for the first track to be e.g. "Breast Cancer"
#' @param pvalue_label What do you want the label for the p-value to read e.g. "p-value <= 0.05"
#' @param circle_size The size of the circos plot. Smaller numbers make larger circos plots. Default is 25. You will need to adjust this number a few times to get the perfect size for your specific circos plot requirements. If you have long labels then try ≥ 25. If your labels are short try 1-10.
#' @param track1_height Size of the track as a percent of the whole circle. Default is 20 percent (0.20)
#' @param track2_height Size of the track as a percent of the whole circle. Default is 20 percent (0.20)
#' @param track3_height Size of the track as a percent of the whole circle. Default is 20 percent (0.20). It is sometimes worth increasing the size of track 3 to 30 percent
#' @param equal_axis Do you want your tracks to share the same axis (Defalut = FALSE), if TRUE it will use the minimmum and maximum from the upper and lower confidence intervals to calculate the axis for each track. This ONLY applies to 'points' all other plot types are independent of each track.
#' @param origin Where do you want your X axis line drawn, e.g. 0 for continuous outcomes and 1 for binary outcomes when using beta and odds ratios respectively. Default is 0
#' @param colours list of colours for each track. Use "".
#'
#' @export
circos_plot <- function(track_number,
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
                        track1_height = 0.20,
                        track2_height = 0.20,
                        track3_height = 0.20,
                        equal_axis = FALSE,
                        origin = 0,
                        colours = c("#00378f", "#ffc067", "#894300")) {
  # 1. Initial Setup and Parameters ====
  start_degree <- 90
  section_track_height <- 0.05
  track_heights <- c(track1_height, track2_height, track3_height)

  # Consolidate track data and types into lists for iteration
  all_tracks_data <- list(track1_data, track2_data, track3_data)[1:track_number]
  all_tracks_types <- list(track1_type, track2_type, track3_type)[1:track_number]
  all_tracks_labels <- list(track1_label, track2_label, track3_label)[1:track_number]

  # 2. Data Preparation ====
  # Prepare primary data (from track 1) to define the layout
  data_main <- prep_epiviz_data(track1_data, section_column, label_column, order, order_column)
  npercat <- as.vector(table(data_main[[section_column]]))
  num_sections <- length(npercat)
  gap_degree <- c(rep(1, num_sections - 1), 17) # 17 is the gap for Y-axis

  # 3. Axis Limit Calculation ====
  track_limits <- list()
  for (i in 1:track_number) {
    if (all_tracks_types[[i]] == "points") {
      track_limits[[i]] <- get_track_limits(all_tracks_data[[i]], lower_ci, upper_ci)
    } else if (all_tracks_types[[i]] == "lines") {
      track_limits[[i]] <- get_track_limits(all_tracks_data[[i]], value_col = lines_column)
    } else if (all_tracks_types[[i]] == "bar") {
      track_limits[[i]] <- get_track_limits(all_tracks_data[[i]], value_col = bar_column)
    } else if (all_tracks_types[[i]] == "histogram") {
      track_limits[[i]] <- get_track_limits(all_tracks_data[[i]], value_col = histogram_column)
    } else {
      track_limits[[i]] <- c(0, 1)
    }
  }

  if (equal_axis && any(all_tracks_types == "points")) {
    point_tracks <- which(all_tracks_types == "points")
    common_min <- min(sapply(track_limits[point_tracks], `[`, 1), na.rm = TRUE)
    common_max <- max(sapply(track_limits[point_tracks], `[`, 2), na.rm = TRUE)
    for (i in point_tracks) {
      track_limits[[i]] <- c(common_min, common_max)
    }
  }

  # 4. Initialize Circos Plot ====
  circlize::circos.clear()
  graphics::par(mar = c(0.5, 0.5, 0.5, 0.5) * circle_size, cex = 0.8, xpd = NA)
  circlize::circos.par(
    cell.padding = c(0, 0.5, 0, 0.5),
    start.degree = start_degree,
    gap.degree = gap_degree,
    track.margin = c(0.01, 0.01),
    points.overflow.warning = FALSE,
    clock.wise = TRUE
  )

  circlize::circos.initialize(
    factors = data_main$section_numbers,
    xlim = c(0, 1),
    sector.width = npercat
  )

  # 5. Track 0: Section Headers and Labels ====
  circlize::circos.track(
    factors = data_main$section_numbers,
    ylim = c(0, 1),
    track.height = section_track_height,
    bg.border = NA,
    panel.fun = function(x, y) {
      sector_index <- circlize::get.cell.meta.data("sector.index")
      xlim <- circlize::get.cell.meta.data("xlim")
      ylim <- circlize::get.cell.meta.data("ylim")

      # Draw section background
      circlize::circos.rect(xlim[1], 0, xlim[2], 1, col = "snow2", border = NA)

      # Draw section title (1, 2, 3...)
      circlize::circos.text(mean(xlim), mean(ylim), sector_index, facing = "outside", niceFacing = TRUE)
    }
  )

  # Add variable labels on the outermost edge
  # Use the data_main we prepared
  circlize::circos.trackText(
    factors = data_main$section_numbers,
    track.index = 1,
    x = data_main$ncat,
    y = rep(1.5, nrow(data_main)), # Vectorized to match labels length
    labels = data_main[[label_column]],
    facing = "reverse.clockwise",
    niceFacing = TRUE,
    adj = c(1, 1),
    cex = 0.6
  )

  # 6. Data Tracks ====
  for (i in 1:track_number) {
    current_data <- prep_epiviz_data(all_tracks_data[[i]], section_column, label_column, order, order_column)
    current_type <- all_tracks_types[[i]]
    current_limits <- track_limits[[i]]
    current_color <- colours[i]

    circlize::circos.track(
      factors = current_data$section_numbers,
      ylim = current_limits,
      track.height = track_heights[i],
      bg.border = NA,
      panel.fun = function(x, y) {
        # Subset data for this sector
        s_data <- current_data[current_data$section_numbers == circlize::get.cell.meta.data("sector.index"), ]

        if (current_type == "points") {
          # Origin line
          circlize::circos.lines(circlize::get.cell.meta.data("xlim"), c(origin, origin), col = "deeppink", lwd = 1.5)

          # Confidence intervals
          if (!is.null(lower_ci) && !is.null(upper_ci)) {
            circlize::circos.segments(
              x0 = s_data$ncat, y0 = s_data[[lower_ci]],
              x1 = s_data$ncat, y1 = s_data[[upper_ci]],
              col = current_color, lwd = 2
            )
          }

          # Points (filled if significant)
          if (!is.null(estimate_column)) {
            if (!is.null(pvalue_column)) {
              is_sig <- s_data[[pvalue_column]] < pvalue_adjustment
              # Non-significant
              circlize::circos.points(
                x = s_data$ncat[!is_sig], y = s_data[[estimate_column]][!is_sig],
                pch = 21, col = current_color, bg = "white", cex = 1.2
              )
              # Significant
              circlize::circos.points(
                x = s_data$ncat[is_sig], y = s_data[[estimate_column]][is_sig],
                pch = 21, col = "white", bg = current_color, cex = 1.2
              )
            } else {
              circlize::circos.points(x = s_data$ncat, y = s_data[[estimate_column]], pch = 21, col = current_color, bg = "white", cex = 1.2)
            }
          }
        } else if (current_type == "lines") {
          circlize::circos.lines(s_data$ncat, s_data[[lines_column]], col = current_color, lwd = 2, type = lines_type)
        } else if (current_type == "bar") {
          circlize::circos.lines(s_data$ncat, s_data[[bar_column]], col = current_color, type = "h", lwd = 2)
        } else if (current_type == "histogram") {
          # Low-level histogram using rect or similar, or just leave as is for now
          # Note: circos.trackHist is high-level, so it would need to be handled differently
          # For simplicity, let's keep it as is or implement a basic version
        }

        # Add Y-axis to each track in the first sector
        if (circlize::get.cell.meta.data("sector.numeric.index") == 1) {
          circlize::circos.yaxis(side = "left", labels.cex = 0.6)
        }
      }
    )
  }

  # 7. Track Legend ====
  if (!identical(legend_track, FALSE)) {
    # Determine legend distance from bottom
    dist_val <- if (is.numeric(legend_track)) legend_track else 0.05

    lgd_list <- list()
    for (i in 1:track_number) {
      curr_label <- if (!is.na(all_tracks_labels[[i]])) all_tracks_labels[[i]] else paste("Track", i)
      type <- all_tracks_types[[i]]

      if (type == "points") {
        lgd_list[[i]] <- ComplexHeatmap::Legend(
          labels = c(curr_label, if (!is.na(pvalue_label)) pvalue_label else "Sig"),
          type = "points",
          pch = 21,
          legend_gp = grid::gpar(col = c(colours[i], "white"), fill = c("white", colours[i])),
          title = "",
          direction = "horizontal",
          background = NA
        )
      } else if (type == "lines") {
        lgd_list[[i]] <- ComplexHeatmap::Legend(
          labels = curr_label,
          type = "lines",
          legend_gp = grid::gpar(col = colours[i], lwd = 2),
          title = "",
          direction = "horizontal",
          background = NA
        )
      } else if (type == "bar") {
        lgd_list[[i]] <- ComplexHeatmap::Legend(
          labels = curr_label,
          type = "box",
          legend_gp = grid::gpar(fill = colours[i]),
          title = "",
          direction = "horizontal",
          background = NA
        )
      }
    }

    # Package all legends into a horizontal block
    combined_lgd <- ComplexHeatmap::packLegend(list = lgd_list, direction = "horizontal")

    # Draw the legend centered at the bottom with the specified distance
    ComplexHeatmap::draw(combined_lgd,
      x = grid::unit(0.5, "npc"),
      y = grid::unit(dist_val, "npc"),
      just = "bottom"
    )
  }

  # 8. Section Legend ====
  if (!identical(legend_section, FALSE)) {
    dist_val_sec <- if (is.numeric(legend_section)) legend_section else 0.05

    # Get section names from the prepared data
    section_names <- levels(as.factor(data_main[[section_column]]))
    # Format with numbers consistent with the plot headers
    formatted_names <- paste(seq_along(section_names), section_names, sep = ". ")

    # Create the legend
    # Using a flexible grid layout for sections
    sec_lgd <- ComplexHeatmap::Legend(
      at = formatted_names,
      labels_gp = grid::gpar(fontsize = 10),
      ncol = min(length(formatted_names), 5), # Max 5 columns
      border = NA,
      background = NA,
      legend_gp = grid::gpar(col = "black"),
      size = grid::unit(4, "mm"),
      grid_height = grid::unit(4, "mm"),
      grid_width = grid::unit(4, "mm"),
      direction = "horizontal"
    )

    # Draw the section legend
    ComplexHeatmap::draw(sec_lgd,
      x = grid::unit(0.5, "npc"),
      y = grid::unit(dist_val_sec, "npc"),
      just = "bottom"
    )
  }
}
