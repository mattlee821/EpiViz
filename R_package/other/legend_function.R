# Legend ====

## 1. Assign the legend points
if(legend == TRUE && track_number == 1){

  legend1 <- ComplexHeatmap::Legend(at = c(track2_label),
                                    labels_gp = grid::gpar(fontsize = 15),
                                    ncol = 1,
                                    border = NA, # color of legend borders, also for the ticks in the continuous legend
                                    background = NA, # background colors
                                    legend_gp = grid::gpar(col = c(discrete_palette[3])), # graphic parameters for the legend
                                    type = "points", # type of legends, can be grid, points and lines
                                    pch = 19, # type of points
                                    size = grid::unit(15, "mm"), # size of points
                                    grid_height	= grid::unit(15, "mm"),
                                    grid_width = grid::unit(15, "mm"),
                                    direction = "vertical")}

## 6.A2 - Assign the legend points
if(legend == TRUE && track_number >= 2){

  legend1 <- ComplexHeatmap::Legend(at = c(track2_label, track3_label),
                                    labels_gp = grid::gpar(fontsize = 15),
                                    ncol = 1,
                                    border = NA, # color of legend borders, also for the ticks in the continuous legend
                                    background = NA, # background colors
                                    legend_gp = grid::gpar(col = c(discrete_palette[3], discrete_palette[1])), # graphic parameters for the legend
                                    type = "points", # type of legends, can be grid, points and lines
                                    pch = 19, # type of points
                                    size = grid::unit(15, "mm"), # size of points
                                    grid_height	= grid::unit(15, "mm"),
                                    grid_width = grid::unit(15, "mm"),
                                    direction = "vertical")}

## 6.A3 - Assign the legend points
if(legend == TRUE && track_number >= 3){

  legend1 <- ComplexHeatmap::Legend(at = c(track2_label, track3_label, track4_label),
                                    labels_gp = grid::gpar(fontsize = 15),
                                    ncol = 1,
                                    border = NA, # color of legend borders, also for the ticks in the continuous legend
                                    background = NA, # background colors
                                    legend_gp = grid::gpar(col = c(discrete_palette[3], discrete_palette[1], discrete_palette[5])), # graphic parameters for the legend
                                    type = "points", # type of legends, can be grid, points and lines
                                    pch = 19, # type of points
                                    size = grid::unit(15, "mm"), # size of points
                                    grid_height	= grid::unit(15, "mm"),
                                    grid_width = grid::unit(15, "mm"),
                                    direction = "vertical")}

## 6.B - Assign Pvalue legend point
if(legend == TRUE){

  legend2 <- ComplexHeatmap::Legend(at = pvalue_label, # breaks, can be wither numeric or character
                                    labels_gp = grid::gpar(fontsize = 15),
                                    ncol = 1,
                                    border = NA, # color of legend borders, also for the ticks in the continuous legend
                                    background = NA, # background colors
                                    legend_gp = grid::gpar(col = c("black")), # graphic parameters for the legend
                                    type = "points", # type of legends, can be grid, points and lines
                                    pch = 1, # type of points
                                    size = grid::unit(15, "mm"), # size of points
                                    grid_height	= grid::unit(15, "mm"),
                                    grid_width = grid::unit(15, "mm"),
                                    direction = "vertical")

  ## 6.C - Assign legend section labelling
  names <- levels(as.factor(data[[section_column]]))
  names <- paste(1:nlevels(data[[section_column]]), names, sep=". ")
  legend3 <- ComplexHeatmap::Legend(at = names,
                                    labels_gp = grid::gpar(fontsize = 15),
                                    nrow = 4,
                                    ncol = 7,
                                    border = NA, # color of legend borders, also for the ticks in the continuous legend
                                    background = NA, # background colors
                                    legend_gp = grid::gpar(col = c("black")), # graphic parameters for the legend
                                    size = grid::unit(15, "mm"), # size of points
                                    grid_height	= grid::unit(15, "mm"),
                                    grid_width = grid::unit(10, "mm"),
                                    direction = "horizontal")

  ## 6.D - Pack lagend together
  legend4 <- ComplexHeatmap::packLegend(legend1, legend2, direction = "vertical", gap = grid::unit(0, "mm"))
  legend <- ComplexHeatmap::packLegend(legend4, legend3, direction = "horizontal", gap = grid::unit(0, "mm"))

  ## 6.E - Layer legend ontop of plot
  grid::pushViewport(grid::viewport(x = grid::unit(0.5, "npc"),
                                    y = grid::unit(0.068, "npc"),
                                    width = grid::grobWidth(legend),
                                    height = grid::grobHeight(legend),
                                    just = c("center", "top")))
  grid::grid.draw(legend)
  grid::upViewport()}
