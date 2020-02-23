# source function ====
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
#' @param legend Do you want a legend = TRUE or FALSE. FALSE by default
#' @param track1_label What do you want the label for the first track to be e.g. "Body Mass Index"
#' @param track2_label What do you want the label for the first track to be e.g. "Corondary Heart Disease"
#' @param track3_label What do you want the label for the first track to be e.g. "Breast Cancer"
#' @param pvalue_label What do you want the label for the p-value to read e.g. "p-value <= 0.05"
#' @param circle_size The size of the circos plot. Smaller numbers make larger circos plots. Default is 25. You will need to adjust this number a few times to get the perfect size for your specific circos plot requirements. If you have long labels then try ≥ 25. If your labels are short try 1-10.
#' @param track1_height Size of the track as a percent of the whole circle. Default is 20 percent (0.20)
#' @param track2_height Size of the track as a percent of the whole circle. Default is 20 percent (0.20)
#' @param track3_height Size of the track as a percent of the whole circle. Default is 20 percent (0.20). It is sometimes worth increasing the size of track 3 to 30 percent

#'
#' @export
#'
#' @examples circos_plot(track_number = 3,
#' track1_data = EpiViz_data1,
#' track2_data = EpiViz_data2,
#' track3_data = EpiViz_data3,
#' track1_type = "points",
#' track2_type = "lines",
#' track3_type = "bar",
#' label_column = 1,
#' section_column = 9,
#' estimate_column = 2,
#' pvalue_column = 3,
#' pvalue_adjustment = 1,
#' lower_ci = 4,
#' upper_ci = 5,
#' lines_column = 2,
#' lines_type = "o",
#' bar_column = 2,
#' legend = FALSE,
#' circle_size = 25)
#'
circos_plot <- function(track_number,
                        track1_data,
                        track2_data,
                        track3_data,
                        track1_type,
                        track2_type,
                        track3_type,
                        label_column,
                        section_column,
                        order = TRUE,
                        order_column,
                        estimate_column,
                        pvalue_column,
                        pvalue_adjustment,
                        lower_ci,
                        upper_ci,
                        lines_column,
                        lines_type = "o",
                        bar_column,
                        histogram_column,
                        histogram_binsize = 0.01,
                        histogram_densityplot = FALSE,
                        legend = FALSE,
                        track1_label = NA,
                        track2_label = NA,
                        track3_label = NA,
                        pvalue_label = NA,
                        circle_size = 25,
                        track1_height = 0.20,
                        track2_height = 0.20,
                        track3_height = 0.20){

  # Default plot paramaters ====
  track1 <- 1 # track 1 is your section header
  track2 <- 2 # you start plotting your data on track 2
  track3 <- 3
  track4 <- 4
  x_axis_index <- 1
  track_axis_reference <- 0
  margins <- c(0.5, 0.5, 0.5, 0.5) * 25 # A numerical vector of the form c(bottom, left, top, right) which gives the number of lines of margin to be specified on the four sides of the plot
  start_gap <- 17 # indicates gap at start for Y axis scale, this is a percentage so the larger the number the larger the empty gap
  start_degree <- 90 # starting point of the cirlce in degrees (90 is top)
  section_track_height <- 0.10 # size of secton header track as percent of whole circle


  # Customisable paramaters ====
  ## Colours
  discrete_palette <- c("#00378f", # track 1 colour
                        "#ffc067", # track 2 colour
                        "#894300") # track 3 colour

  ## section header specifics
  section_fill_colour <- "snow2"
  section_text_colour <- "black"
  section_line_colour <- "grey"
  section_line_thickness <- 1.5
  section_line_type <- 1

  ## reference lines that go around the tracks
  reference_line_colour <- "deeppink"
  reference_line_thickness <- 1.5
  reference_line_type <- 1

  ## point specifics
  point_pch <- 21
  point_cex <- 1.5

  point_col1 <- discrete_palette[1]
  point_bg1 <- "white"
  point_col1_sig <- "white"
  point_bg1_sig <- discrete_palette[1]

  point_col2 <- discrete_palette[2]
  point_bg2 <- "white"
  point_col2_sig <- "white"
  point_bg2_sig <- discrete_palette[2]

  point_col3 <- discrete_palette[3]
  point_bg3 <- "white"
  point_col3_sig <- "white"
  point_bg3_sig <- discrete_palette[3]

  ## confidence intervals
  ci_lwd <- 5
  ci_lty <- 1
  ci_col1 <- discrete_palette[1]
  ci_col2 <- discrete_palette[2]
  ci_col3 <- discrete_palette[3]

  ## lines specifics
  lines_col1 <- discrete_palette[1]
  lines_col2 <- discrete_palette[2]
  lines_col3 <- discrete_palette[3]

  lines_lwd <- 3
  lines_lty <- 1

  ## y axis specifics
  y_axis_location <- "left"
  y_axis_tick <- FALSE
  y_axis_tick_length <- 0
  y_axis_label_cex <- 0.75

  ## label specifics
  label_distance <- 1.5 # distance from track 0 to plot labels
  label_col <- "black"
  label_cex <- 0.6


  # plot set-up ====
  ## the plot region is set-up based on track1_data
  data <- track1_data

  ## 1. organise the data based on section and alphabetically within that based on label
  if (order == TRUE){
    data <- data[order(data[[section_column]], data[[label_column]]),]
  }
  else if(order == FALSE){
    data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
    data <- data[order(data[[section_column]], data[[label_column]]),]
  }

  ## 2. add column of positions of where each data point will be in th track - this is position of values within the track and should be 1:n depedning on number of variables in each section and is based also on individual sections. this will give a number 1-n for each individual metabolite in each section as a position within the section for plotting values.
  data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN = seq_along))

  ## 3. set parameter - this sets the paramater of the sections of the circos plot so that you can plot within individual sections
  npercat <- as.vector(table(data[[section_column]]))

  ## 4. Standardise data$x so that the axis is from 0-1 - this provides for each section an individual x axis
  getaxis <- function(data) {

    for (i in 1:nrow(data)) {

      data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
      data$ncat[i]<- data$x[i]/data$n[i]
    }
    return(data)
  }

  data <- getaxis(data)

  ## 5. add column that codes sections as numbers - this will be the label for section headings. This can then be translated in the legend or figure title
  data$section_numbers = factor(data[[section_column]],
                                labels = 1:nlevels(data[[section_column]]))

  ## 6. set gap for axis - spacing between sections. It is 1-n where n is 1 minus the total number of sections - last number indicates gap at start for Y axis scale, this is a percentage so the larger the number the larger the empty gap
  gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

  ## 7. clear plotting area
  circlize::circos.clear()

  ## 8. initiate blank page to plot on top of
  graphics::par(mar = c(0.6, 0.5, 0.5, 0.5) * circle_size,
      cex = 0.8,
      xpd = NA) # A logical value or NA. If FALSE, all plotting is clipped to the plot region, if TRUE, all plotting is clipped to the figure region, and if NA, all plotting is clipped to the device region. See also clip.

  ## 9. creat circle paramaters
  circlize::circos.par(cell.padding = c(0, 0.5, 0, 0.5),
                       start.degree = start_degree, # starting point of the circle
                       gap.degree = gap, # gap between two neighbour sections
                       track.margin = c(0.012, 0.012), #blank area outside of the plotting area
                       points.overflow.warning = FALSE, #this dictates whether warnings will pop up if plots are plotted outside of the plotting region (this is to do with teh plotting region not being circular and instead being rectangular) - keep this as FALSE
                       track.height = section_track_height, #height of the section track as percent of whole circle
                       clock.wise = TRUE) #direction to add sections

  ## 10. initiate circle
  circlize::circos.initialize(factors = data$section_numbers,
                              xlim = c(0, 1),
                              sector.width = npercat)

  ## 11. create and plot section headers
  circlize::circos.trackPlotRegion(factors = data$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                   track.index = track1, #the track you are plotting
                                   x = data$ncat, #the x axis is dictated by the number of values in our data set
                                   ylim = c(0, 1), #the y axis is set based on the track width you want as it will impact the size of text you can have in this track
                                   track.height = 0.05, #size of track as % of whole circle
                                   panel.fun = function(x, y) {
                                     chr = circlize::get.cell.meta.data("sector.index") #dont change as this gathers all of the info you need automatically
                                     xlim = circlize::get.cell.meta.data("xlim") #dont change as this gathers all of the info you need automatically
                                     ylim = circlize::get.cell.meta.data("ylim") #dont change as this gathers all of the info you need automatically
                                     circlize::circos.rect(xlim[1], 0, xlim[2], 1, # n (+ and -) length of track away from centre (low number means smaller) - want it large enough to encompass text
                                                           border = NA, #give the track a border
                                                           col = section_fill_colour) #colour of track
                                     circlize::circos.text(mean(xlim), #text location on x axis
                                                           mean(ylim), #text location on y axis
                                                           chr, #colour of text, default blue
                                                           cex = 1, #text size
                                                           facing = "outside", #diretion of text
                                                           niceFacing = TRUE, #flip so text is readable
                                                           col = section_text_colour)
                                   },
                                   bg.border = NA) #background border colour

  ## 12. add labels
  circlize::circos.trackText(factors = data$section_numbers,
                             track.index = track1, #choose labels based on the track we have just made as you can only plot text once a track has been created
                             x = data$ncat, #location on the x axis where we will plot the lables
                             y = data$b * 0 + label_distance, #dictates where the labels are plotted - * 0 to give 0 and then choose how far away from the 0 we want to plot the text (this will be trial and error before you get what works best for your data set)
                             labels = data[[label_column]], #where you are taking the names for the labels from
                             facing = "reverse.clockwise",
                             niceFacing = TRUE, #flip the text so it is readable
                             adj = c(1, 1),
                             col = label_col,
                             cex = label_cex) #size of the text







  # track 1 ====
  ## points ====
  if(track_number >= 1 && track1_type == "points"){
    data <- track1_data
    track.index <- 2

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    a <- min(data[[lower_ci]])
    b <- min(data[[upper_ci]])
    axis_min <- min(a,b)
    axis_min <- round(axis_min, 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    a <- max(data[[lower_ci]])
    b <- max(data[[upper_ci]])
    axis_max <- max(a,b)
    axis_max <- round(axis_max, 3)
    axis_max <- round(axis_max + (axis_max * 0.01), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    for(i in 1:nlevels(data$section_numbers)){
      data1 = subset(data, section_numbers == i)

      circlize::circos.trackPlotRegion(factors = data1$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                       track.index = track.index,
                                       x = data1$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                       y = data1[[estimate_column]], #variable you want to plot
                                       ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                       track.height = track1_height, #how big is the track as % of circle

                                       #Set sector background
                                       bg.border = NA,
                                       bg.col = NA,

                                       #Map values
                                       panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code

                                         # plot '0' reference line
                                         circlize::circos.lines(x = x,
                                                                y = y * 0 + track_axis_reference,
                                                                col = reference_line_colour, #set the 0 line colour to something distinctive
                                                                lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                                                lty = reference_line_type)

                                         # confidence interval
                                         circlize::circos.segments(x0 = data1$ncat, # x coordinates for starting point
                                                                   x1 = data1$ncat, # x coordinates for end point
                                                                   y0 = data1[[estimate_column]] * 0 - -(data1[[lower_ci]]), # y coordinates for start point
                                                                   y1 = data1[[estimate_column]] * 0 + data1[[upper_ci]], # y coordinates for end point
                                                                   col = ci_col1,
                                                                   lwd = ci_lwd,
                                                                   lty = ci_lty,
                                                                   sector.index = i)})}

    ## 4. layer on top of the confidence intervals the effect estimates
    ### a. points not reaching signfiicance
    circlize::circos.trackPoints(factors = subset(data, data[[pvalue_column]] > pvalue_adjustment)$section_numbers,
                                 track.index = track.index,
                                 x = subset(data, data[[pvalue_column]] > pvalue_adjustment)$ncat,
                                 y = subset(data, data[[pvalue_column]] > pvalue_adjustment)[[estimate_column]],
                                 cex = point_cex,
                                 pch = point_pch,
                                 col = point_col1,
                                 bg = point_bg1)
    ### b. points reaching significance
    circlize::circos.trackPoints(factors = subset(data, data[[pvalue_column]] < pvalue_adjustment)$section_numbers,
                                 track.index = track.index,
                                 x = subset(data, data[[pvalue_column]] < pvalue_adjustment)$ncat,
                                 y = subset(data, data[[pvalue_column]] < pvalue_adjustment)[[estimate_column]],
                                 cex = point_cex,
                                 pch = point_pch,
                                 col = point_col1_sig,
                                 bg = point_bg1_sig)

    ## 5. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }


  ## lines ====
  if(track_number >= 1 && track1_type == "lines"){
    data <- track1_data
    track.index <- 2

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[lines_column]]), 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    axis_max <- round(max(data[[lines_column]]), 3)
    axis_max <- round(axis_max + (axis_max * 0.1), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackPlotRegion(factors = data$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                     track.index = track.index,
                                     x = data$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                     y = data[[lines_column]], #variable you want to plot
                                     ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                     track.height = track1_height, #how big is the track as % of circle

                                     #Set sector background
                                     bg.border = NA,
                                     bg.col = NA,

                                     #Map values
                                     panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code


                                       circlize::circos.lines(x = x,
                                                              y = y,
                                                              col = lines_col1,
                                                              lwd = lines_lwd,
                                                              lty = lines_lty,
                                                              type = lines_type)

                                       # plot '0' reference line
                                       # circlize::circos.lines(x = x,
                                       #                        y = y * 0 + track_axis_reference,
                                       #                        col = reference_line_colour, #set the 0 line colour to something distinctive
                                       #                        lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                       #                        lty = reference_line_type)
                                       })

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }



  ## barplot ====
  if(track_number >= 1 && track1_type == "bar"){
    data <- track1_data
    track.index <- 2

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[bar_column]]), 3)
    axis_max <- round(max(data[[bar_column]]), 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackPlotRegion(factors = data$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                     track.index = track.index,
                                     x = data$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                     y = data[[bar_column]], #variable you want to plot
                                     ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                     track.height = track1_height, #how big is the track as % of circle

                                     #Set sector background
                                     bg.border = NA,
                                     bg.col = NA,

                                     #Map values
                                     panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code


                                       circlize::circos.lines(x = x,
                                                              y = y,
                                                              col = lines_col1,
                                                              lwd = 1,
                                                              lty = lines_lty,
                                                              type = "s",
                                                              area = T,
                                                              border = "White",
                                                              baseline = "bottom")


                                       # # plot '0' reference line
                                       # circlize::circos.lines(x = x,
                                       #                        y = y * 0 + track_axis_reference,
                                       #                        col = reference_line_colour, #set the 0 line colour to something distinctive
                                       #                        lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                       #                        lty = reference_line_type)
                                       })

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }




  ## histogram ====
  if(track_number >= 1 && track1_type == "histogram"){
    data <- track1_data
    track.index <- 2

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[histogram_column]]), 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    axis_max <- round(max(data[[histogram_column]]), 3)
    axis_max <- round(axis_max + (axis_max * 0.1), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackHist(factors = data$section_numbers,
                               x = data[[histogram_column]],
                               track.height = track1_height,
                               track.index = NULL,
                               col = lines_col1,
                               border = lines_col1,
                               bg.border = NA,
                               draw.density = histogram_densityplot,
                               bin.size = histogram_binsize)

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)

    }


  # track 2 ====
  ## points ====
  if(track_number >= 2 && track2_type == "points"){
    data <- track2_data
    track.index <- 3

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    a <- min(data[[lower_ci]])
    b <- min(data[[upper_ci]])
    axis_min <- min(a,b)
    axis_min <- round(axis_min, 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    a <- max(data[[lower_ci]])
    b <- max(data[[upper_ci]])
    axis_max <- max(a,b)
    axis_max <- round(axis_max, 3)
    axis_max <- round(axis_max + (axis_max * 0.01), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    for(i in 1:nlevels(data$section_numbers)){
      data1 = subset(data, section_numbers == i)

      circlize::circos.trackPlotRegion(factors = data1$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                       track.index = track.index,
                                       x = data1$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                       y = data1[[estimate_column]], #variable you want to plot
                                       ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                       track.height = track2_height, #how big is the track as % of circle

                                       #Set sector background
                                       bg.border = NA,
                                       bg.col = NA,

                                       #Map values
                                       panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code

                                         # plot '0' reference line
                                         circlize::circos.lines(x = x,
                                                                y = y * 0 + track_axis_reference,
                                                                col = reference_line_colour, #set the 0 line colour to something distinctive
                                                                lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                                                lty = reference_line_type)

                                         # confidence interval
                                         circlize::circos.segments(x0 = data1$ncat, # x coordinates for starting point
                                                                   x1 = data1$ncat, # x coordinates for end point
                                                                   y0 = data1[[estimate_column]] * 0 - -(data1[[lower_ci]]), # y coordinates for start point
                                                                   y1 = data1[[estimate_column]] * 0 + data1[[upper_ci]], # y coordinates for end point
                                                                   col = ci_col2,
                                                                   lwd = ci_lwd,
                                                                   lty = ci_lty,
                                                                   sector.index = i)})}

    ## 4. layer on top of the confidence intervals the effect estimates
    ### a. points not reaching signfiicance
    circlize::circos.trackPoints(factors = subset(data, data[[pvalue_column]] > pvalue_adjustment)$section_numbers,
                                 track.index = track.index,
                                 x = subset(data, data[[pvalue_column]] > pvalue_adjustment)$ncat,
                                 y = subset(data, data[[pvalue_column]] > pvalue_adjustment)[[estimate_column]],
                                 cex = point_cex,
                                 pch = point_pch,
                                 col = point_col2,
                                 bg = point_bg2)
    ### b. points reaching significance
    circlize::circos.trackPoints(factors = subset(data, data[[pvalue_column]] < pvalue_adjustment)$section_numbers,
                                 track.index = track.index,
                                 x = subset(data, data[[pvalue_column]] < pvalue_adjustment)$ncat,
                                 y = subset(data, data[[pvalue_column]] < pvalue_adjustment)[[estimate_column]],
                                 cex = point_cex,
                                 pch = point_pch,
                                 col = point_col2_sig,
                                 bg = point_bg2_sig)

    ## 5. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }



  ## lines ====
  if(track_number >= 2 && track2_type == "lines"){
    data <- track2_data
    track.index <- 3

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[lines_column]]), 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    axis_max <- round(max(data[[lines_column]]), 3)
    axis_max <- round(axis_max + (axis_max * 0.1), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackPlotRegion(factors = data$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                     track.index = track.index,
                                     x = data$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                     y = data[[lines_column]], #variable you want to plot
                                     ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                     track.height = track2_height, #how big is the track as % of circle

                                     #Set sector background
                                     bg.border = NA,
                                     bg.col = NA,

                                     #Map values
                                     panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code


                                       circlize::circos.lines(x = x,
                                                              y = y,
                                                              col = lines_col2,
                                                              lwd = lines_lwd,
                                                              lty = lines_lty,
                                                              type = lines_type)

                                       # # plot '0' reference line
                                       # circlize::circos.lines(x = x,
                                       #                        y = y * 0 + track_axis_reference,
                                       #                        col = reference_line_colour, #set the 0 line colour to something distinctive
                                       #                        lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                       #                        lty = reference_line_type)
                                       })

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }





  ## barplot ====
  if(track_number >= 2 && track2_type == "bar"){
    data <- track1_data
    track.index <- 3

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[bar_column]]), 3)
    axis_max <- round(max(data[[bar_column]]), 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackPlotRegion(factors = data$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                     track.index = track.index,
                                     x = data$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                     y = data[[bar_column]], #variable you want to plot
                                     ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                     track.height = track2_height, #how big is the track as % of circle

                                     #Set sector background
                                     bg.border = NA,
                                     bg.col = NA,

                                     #Map values
                                     panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code


                                       circlize::circos.lines(x = x,
                                                              y = y,
                                                              col = lines_col2,
                                                              lwd = 1,
                                                              lty = lines_lty,
                                                              type = "s",
                                                              area = T,
                                                              border = "White",
                                                              baseline = "bottom")


                                       # # plot '0' reference line
                                       # circlize::circos.lines(x = x,
                                       #                        y = y * 0 + track_axis_reference,
                                       #                        col = reference_line_colour, #set the 0 line colour to something distinctive
                                       #                        lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                       #                        lty = reference_line_type)
                                       })

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }





  ## histogram ====
  if(track_number >= 2 && track2_type == "histogram"){
    data <- track2_data
    track.index <- 3

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[histogram_column]]), 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    axis_max <- round(max(data[[histogram_column]]), 3)
    axis_max <- round(axis_max + (axis_max * 0.1), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackHist(factors = data$section_numbers,
                               x = data[[histogram_column]],
                               track.height = track2_height,
                               track.index = NULL,
                               col = lines_col2,
                               border = lines_col2,
                               bg.border = NA,
                               draw.density = histogram_densityplot,
                               bin.size = histogram_binsize)

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)

  }



  # track 3 ====
  ## points ====
  if(track_number >= 3 && track3_type == "points"){
    data <- track3_data
    track.index <- 4

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    a <- min(data[[lower_ci]])
    b <- min(data[[upper_ci]])
    axis_min <- min(a,b)
    axis_min <- round(axis_min, 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    a <- max(data[[lower_ci]])
    b <- max(data[[upper_ci]])
    axis_max <- max(a,b)
    axis_max <- round(axis_max, 3)
    axis_max <- round(axis_max + (axis_max * 0.01), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    for(i in 1:nlevels(data$section_numbers)){
      data1 = subset(data, section_numbers == i)

      circlize::circos.trackPlotRegion(factors = data1$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                       track.index = track.index,
                                       x = data1$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                       y = data1[[estimate_column]], #variable you want to plot
                                       ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                       track.height = track3_height, #how big is the track as % of circle

                                       #Set sector background
                                       bg.border = NA,
                                       bg.col = NA,

                                       #Map values
                                       panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code

                                         # plot '0' reference line
                                         circlize::circos.lines(x = x,
                                                                y = y * 0 + track_axis_reference,
                                                                col = reference_line_colour, #set the 0 line colour to something distinctive
                                                                lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                                                lty = reference_line_type)

                                         # confidence interval
                                         circlize::circos.segments(x0 = data1$ncat, # x coordinates for starting point
                                                                   x1 = data1$ncat, # x coordinates for end point
                                                                   y0 = data1[[estimate_column]] * 0 - -(data1[[lower_ci]]), # y coordinates for start point
                                                                   y1 = data1[[estimate_column]] * 0 + data1[[upper_ci]], # y coordinates for end point
                                                                   col = ci_col3,
                                                                   lwd = ci_lwd,
                                                                   lty = ci_lty,
                                                                   sector.index = i)})}

    ## 4. layer on top of the confidence intervals the effect estimates
    ### a. points not reaching signfiicance
    circlize::circos.trackPoints(factors = subset(data, data[[pvalue_column]] > pvalue_adjustment)$section_numbers,
                                 track.index = track.index,
                                 x = subset(data, data[[pvalue_column]] > pvalue_adjustment)$ncat,
                                 y = subset(data, data[[pvalue_column]] > pvalue_adjustment)[[estimate_column]],
                                 cex = point_cex,
                                 pch = point_pch,
                                 col = point_col3,
                                 bg = point_bg3)
    ### b. points reaching significance
    circlize::circos.trackPoints(factors = subset(data, data[[pvalue_column]] < pvalue_adjustment)$section_numbers,
                                 track.index = track.index,
                                 x = subset(data, data[[pvalue_column]] < pvalue_adjustment)$ncat,
                                 y = subset(data, data[[pvalue_column]] < pvalue_adjustment)[[estimate_column]],
                                 cex = point_cex,
                                 pch = point_pch,
                                 col = point_col3_sig,
                                 bg = point_bg3_sig)

    ## 5. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }



  ## lines ====
  if(track_number >= 3 && track3_type == "lines"){
    data <- track3_data
    track.index <- 4

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[lines_column]]), 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    axis_max <- round(max(data[[lines_column]]), 3)
    axis_max <- round(axis_max + (axis_max * 0.1), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackPlotRegion(factors = data$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                     track.index = track.index,
                                     x = data$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                     y = data[[lines_column]], #variable you want to plot
                                     ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                     track.height = track3_height, #how big is the track as % of circle

                                     #Set sector background
                                     bg.border = NA,
                                     bg.col = NA,

                                     #Map values
                                     panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code


                                       circlize::circos.lines(x = x,
                                                              y = y,
                                                              col = lines_col3,
                                                              lwd = lines_lwd,
                                                              lty = lines_lty,
                                                              type = lines_type)

                                       # # plot '0' reference line
                                       # circlize::circos.lines(x = x,
                                       #                        y = y * 0 + track_axis_reference,
                                       #                        col = reference_line_colour, #set the 0 line colour to something distinctive
                                       #                        lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                       #                        lty = reference_line_type)
                                       })

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }






  ## barplot ====
  if(track_number >= 3 && track3_type == "bar"){
    data <- track1_data
    track.index <- 4

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[bar_column]]), 3)
    axis_max <- round(max(data[[bar_column]]), 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackPlotRegion(factors = data$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                                     track.index = track.index,
                                     x = data$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                                     y = data[[bar_column]], #variable you want to plot
                                     ylim = c(axis_min, axis_max), #co-ordinates of the Y axis of the track
                                     track.height = track3_height, #how big is the track as % of circle

                                     #Set sector background
                                     bg.border = NA,
                                     bg.col = NA,

                                     #Map values
                                     panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code


                                       circlize::circos.lines(x = x,
                                                              y = y,
                                                              col = lines_col3,
                                                              lwd = 1,
                                                              lty = lines_lty,
                                                              type = "s",
                                                              area = T,
                                                              border = "White",
                                                              baseline = "bottom")


                                       # # plot '0' reference line
                                       # circlize::circos.lines(x = x,
                                       #                        y = y * 0 + track_axis_reference,
                                       #                        col = reference_line_colour, #set the 0 line colour to something distinctive
                                       #                        lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                       #                        lty = reference_line_type)
                                       })

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)
  }







  ## histogram ====
  if(track_number >= 3 && track3_type == "histogram"){
    data <- track3_data
    track.index <- 4

    ## 1. prepare data
    if (order == TRUE){
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }
    else if(order == FALSE){
      data[[section_column]] <- stats::reorder(data[[section_column]], data[[order_column]])
      data <- data[order(data[[section_column]], data[[label_column]]),]
    }

    data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

    npercat <- as.vector(table(data[[section_column]]))

    getaxis <- function(data) {
      for (i in 1:nrow(data)) {
        data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
        data$ncat[i]<- data$x[i]/data$n[i]
      }
      return(data)
    }

    data <- getaxis(data)

    data$section_numbers = factor(data[[section_column]],
                                  labels = 1:nlevels(data[[section_column]]))

    gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap)

    ## 2. set axis limits
    axis_min <- round(min(data[[histogram_column]]), 3)
    axis_min <- round(axis_min + (axis_min * 0.1), 3)
    axis_min_half <- round(axis_min/2, 3)

    axis_max <- round(max(data[[histogram_column]]), 3)
    axis_max <- round(axis_max + (axis_max * 0.1), 3)
    axis_max_half <- round(axis_max/2, 3)

    ## 3. create the track and plot the confidence intervals
    circlize::circos.trackHist(factors = data$section_numbers,
                               x = data[[histogram_column]],
                               track.height = track3_height,
                               track.index = NULL,
                               col = lines_col3,
                               border = lines_col3,
                               bg.border = NA,
                               draw.density = histogram_densityplot,
                               bin.size = histogram_binsize)

    ## 4. add axis labels
    circlize::circos.yaxis(side = y_axis_location,
                           sector.index = x_axis_index, #the sector this is plotted in
                           track.index = track.index,
                           at = c(axis_min,  track_axis_reference,  axis_max), #location on the y axis as well as the name of the label
                           tick = y_axis_tick, tick.length = y_axis_tick_length,
                           labels.cex = y_axis_label_cex)

  }



  # this is the end of the plotting aspect of the script ====
  # Legend ====

  ## 1. Assign the legend points
  if(legend == TRUE && track_number == 1){

    legend1 <- ComplexHeatmap::Legend(at = c(track1_label),
                                      labels_gp = grid::gpar(fontsize = 15),
                                      ncol = 1,
                                      border = NA, # color of legend borders, also for the ticks in the continuous legend
                                      background = NA, # background colors
                                      legend_gp = grid::gpar(col = c(discrete_palette[1])), # graphic parameters for the legend
                                      type = "points", # type of legends, can be grid, points and lines
                                      pch = 19, # type of points
                                      size = grid::unit(15, "mm"), # size of points
                                      grid_height	= grid::unit(15, "mm"),
                                      grid_width = grid::unit(15, "mm"),
                                      direction = "vertical")}

  ## 6.A2 - Assign the legend points
  if(legend == TRUE && track_number >= 2){

    legend1 <- ComplexHeatmap::Legend(at = c(track1_label, track2_label),
                                      labels_gp = grid::gpar(fontsize = 15),
                                      ncol = 1,
                                      border = NA, # color of legend borders, also for the ticks in the continuous legend
                                      background = NA, # background colors
                                      legend_gp = grid::gpar(col = c(discrete_palette[1], discrete_palette[2])), # graphic parameters for the legend
                                      type = "points", # type of legends, can be grid, points and lines
                                      pch = 19, # type of points
                                      size = grid::unit(15, "mm"), # size of points
                                      grid_height	= grid::unit(15, "mm"),
                                      grid_width = grid::unit(15, "mm"),
                                      direction = "vertical")}

  ## 6.A3 - Assign the legend points
  if(legend == TRUE && track_number >= 3){

    legend1 <- ComplexHeatmap::Legend(at = c(track1_label, track2_label, track3_label),
                                      labels_gp = grid::gpar(fontsize = 15),
                                      ncol = 1,
                                      border = NA, # color of legend borders, also for the ticks in the continuous legend
                                      background = NA, # background colors
                                      legend_gp = grid::gpar(col = c(discrete_palette[1], discrete_palette[2], discrete_palette[3])), # graphic parameters for the legend
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
    legend_height <- legend@grob[["vp"]][["height"]]
    legend_width <- legend@grob[["vp"]][["width"]]

    # ## 6.E - Layer legend ontop of plot
    grid::pushViewport(grid::viewport(x = grid::unit(0.5, "npc"),
                                      y = grid::unit(0.08, "npc"),
                                      width = legend_width,
                                      height = legend_height,
                                      just = c("center", "top")))
    grid::grid.draw(legend)
    grid::upViewport()}


  }

