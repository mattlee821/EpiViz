# SETUP ====

source("ui.R")

# SHINY OPTIONS ====

# options(shiny.maxRequestSize = 9*1024^2) #Increase file input size to

#------------------------------------------------------------------------------#

server <- shinyServer(function(input, output, session) {
  
  
  
  # HOME ====
  # Download example dataset
  output$downloadexampledata1 <- downloadHandler(
    filename = function() {
      paste0("exampledata1.txt")
    },
    content = function(file) {
      file.copy("exampledata1.txt", file)
    },
    contentType = NA
  )
  
  output$downloadexampledata2 <- downloadHandler(
    filename = function() {
      paste0("exampledata2.txt")
    },
    content = function(file) {
      file.copy("exampledata2.txt", file)
    },
    contentType = NA
  )
  
  output$downloadexampledata3 <- downloadHandler(
    filename = function() {
      paste0("exampledata3.txt")
    },
    content = function(file) {
      file.copy("exampledata3.txt", file)
    },
    contentType = NA
  )
  
  
  
  # ANALYSIS ====
  #  UPLOAD YOUR DATA ====
  # > sidebar panel ====
  # Read data from multiple .csv/.txt files
  track2_data1 <- eventReactive(input$file1, {
    rbindlist(
      lapply(
        input$file1$datapath,
        FUN = read.csv,
        header = TRUE,
        sep = "\t"),
      use.names = TRUE,
      fill = TRUE)
    })
  
  track3_data1 <- eventReactive(input$file2, {
    rbindlist(
      lapply(
        input$file2$datapath,
        FUN = read.csv,
        header = TRUE,
        sep = "\t"),
      use.names = TRUE,
      fill = TRUE)
    })
  
  track4_data1 <- eventReactive(input$file3, {
    rbindlist(
      lapply(
        input$file3$datapath,
        FUN = read.csv,
        header = TRUE,
        sep = "\t"),
      use.names = TRUE,
      fill = TRUE)
    })
  
  # > main panel ====
  # >> Track 1 ====
  # Define conditional element to show main panel only when file(s) uploaded
  output$file_imported <- reactive({
    return(!is.null(input$file1))
  })
  
  outputOptions(output, "file_imported", suspendWhenHidden = FALSE)
  
  # Create data to describe the imported dataset
  output$rowcount <-
    renderText(paste("Total number of rows in uploaded file(s):", nrow(track2_data1())))
  output$colcount <-
    renderText(paste("Total number of columns in uploaded file(s):", ncol(track2_data1())))
  
  # Render head of imported dataset
  output$data1 <- renderTable({
    track2_data1() %>% head
  })
  
  # Render volcano plot
  observeEvent(input$file1,
               handlerExpr = {
                 output$volcanoplot1 <- renderPlotly({
                   volcanoplot <- plot_ly(
                     data = track2_data1(),
                     type = "scatter",
                     colors = NULL,
                     alpha = NULL,
                     x = track2_data1()[[2]],
                     y = -log10(track2_data1()[[3]]),
                     text = track2_data1()[[1]],
                     mode = "markers"
                   ) %>%
                     layout(xaxis = list(title = "effect_estimate"),
                            yaxis = list(title = "-log10(p-value)"))
                 })
               })
  
  
  # >> Track 2 ====
  # Define conditional element to show main panel only when file(s) uploaded
  output$file_imported2 <- reactive({
    return(!is.null(input$file2))
  })
  
  outputOptions(output, "file_imported2", suspendWhenHidden = FALSE)
  
  # Create data to describe the imported dataset
  output$rowcount2 <-
    renderText(paste("Total number of rows in uploaded file(s):", nrow(track3_data1())))
  output$colcount2 <-
    renderText(paste("Total number of columns in uploaded file(s):", ncol(track3_data1())))
  
  # Render head of imported dataset
  output$data2 <- renderTable({
    track3_data1() %>% head
  })
  
  # Render volcano plot
  observeEvent(input$file2,
               handlerExpr = {
                 output$volcanoplot2 <- renderPlotly({
                   volcanoplot <- plot_ly(
                     data = track3_data1(),
                     type = "scatter",
                     colors = NULL,
                     alpha = NULL,
                     x = track3_data1()[[2]],
                     y = -log10(track3_data1()[[3]]),
                     text = track3_data1()[[1]],
                     mode = "markers"
                   ) %>%
                     layout(xaxis = list(title = "effect_estimate"),
                            yaxis = list(title = "-log10(p-value)"))
                 })
               })
  
  # >> Track 3 ====
  # Define conditional element to show main panel only when file(s) uploaded
  output$file_imported3 <- reactive({
    return(!is.null(input$file3))
  })
  
  outputOptions(output, "file_imported3", suspendWhenHidden = FALSE)
  
  # Create data to describe the imported dataset
  output$rowcount3 <-
    renderText(paste("Total number of rows in uploaded file(s):", nrow(track4_data1())))
  output$colcount3 <-
    renderText(paste("Total number of columns in uploaded file(s):", ncol(track4_data1())))
  
  # Render head of imported dataset
  output$data3 <- renderTable({
    track4_data1() %>% head
  })
  
  # Render volcano plot
  observeEvent(input$file3,
               handlerExpr = {
                 output$volcanoplot3 <- renderPlotly({
                   volcanoplot <- plot_ly(
                     data = track4_data1(),
                     type = "scatter",
                     colors = NULL,
                     alpha = NULL,
                     x = track4_data1()[[2]],
                     y = -log10(track4_data1()[[3]]),
                     text = track4_data1()[[1]],
                     mode = "markers"
                   ) %>%
                     layout(xaxis = list(title = "effect_estimate"),
                            yaxis = list(title = "-log10(p-value)"))
                 })
               })
  
  # CIRCOS PARAMETERS ====
  # > sidebar panel ====
  
  output$pval <- renderText(paste0("New threshold: 0.05/", input$pvalue_adjustment, " = ", round(0.05/input$pvalue_adjustment, digits = 8))
  )
  output$pval_label <- renderText(paste0("P > 0.05/", input$pvalue_adjustment))
  
  # When the first file is uploaded, pass the column headings to the selectInput widgets
  observeEvent(input$file1, {
    updateSelectInput(session,
                      "label_column",
                      choices = c("",colnames(track2_data1())))
    
    updateSelectInput(session,
                      "section_column",
                      choices = c("",colnames(track2_data1())))  
    
    updateSelectInput(session,
                      "estimate_column",
                      choices = c("",colnames(track2_data1())))  
    
    updateSelectInput(session,
                      "pvalue_column",
                      choices = c("",colnames(track2_data1())))  
    
    updateSelectInput(session,
                      "confidence_interval_lower_column",
                      choices = c("",colnames(track2_data1()))) 
    
    updateSelectInput(session,
                      "confidence_interval_upper_column",
                      choices = c("",colnames(track2_data1()))) 
    
  }
  )
  
  # Because the my_circos_plot() function expects a column number rather than name,
  # which is what the selectInput widgets return, use the following functions to convert the 
  # column name into the column number
  label_column_number <- reactive({which(colnames(track2_data1())==input$label_column)})
  section_column_number <- reactive({which(colnames(track2_data1())==input$section_column)})
  estimate_column_number <- reactive({which(colnames(track2_data1())==input$estimate_column)})
  pvalue_column_number <- reactive({which(colnames(track2_data1())==input$pvalue_column)})
  confidence_interval_lower_column_number <- reactive({which(colnames(track2_data1())==input$confidence_interval_lower_column)})
  confidence_interval_upper_column_number <- reactive({which(colnames(track2_data1())==input$confidence_interval_upper_column)})
  
  
  
  output$pdf <- renderUI({
    if(file.exists(outfile)){
      tags$iframe(src=outfile,style="height:600px; width:100%")}
  })
  
  outfile <- tempfile("myfile", fileext = ".pdf", tmpdir ="www")
  
  observeEvent(input$circosbutton,
               handlerExpr = {
                 output$pdf <- renderUI({
                   pdf(outfile, width = 35, height = 35, pointsize = 30)
                   isolate({
                     my_circos_plot(
                       track_number = input$track_number,
                       track2_data1 = track2_data1(),
                       track3_data1 = track3_data1(),
                       track4_data1 = track4_data1(),
                       section_column = section_column_number(), # This returns the column number, as defined above.
                       label_column = label_column_number(),
                       estimate_column = estimate_column_number(),
                       pvalue_column = pvalue_column_number(),
                       pvalue_adjustment = (0.05/input$pvalue_adjustment),
                       confidence_interval_lower_column = confidence_interval_lower_column_number(),
                       confidence_interval_upper_column = confidence_interval_upper_column_number(),
                       legend = input$legend,
                       track2_label = input$track2_label,
                       track3_label = input$track3_label,
                       track4_label = input$track4_label,
                       pvalue_label = input$pvalue_label,
                       colours = input$colours)
                   })
                   
                   dev.off()
                   if(file.exists(outfile)){
                     tags$iframe(src=str_sub(outfile,5),style="height:800px; width:100%")}
                 })
               })
  
  # Return a list containing the filename
  
  onStop(function() {
    unlink(outfile, recursive = TRUE)
  })
  
  
  
  # > main panel ====
  
  
  # Keep shiny app awake ====
  output$keepAlive <- renderText({
    req(input$count)
    paste("keep alive ", input$count)
  })
  
})


#------------------------------------------------------------------------------#

shinyApp(ui = ui, server = server)
