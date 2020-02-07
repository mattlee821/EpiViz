# SETUP ====
# load libraries ====
library(shiny)
library(shinydashboard)
library(shinyLP)
library(shinythemes)
library(plotly)
library(ggplot2)
library(data.table)
library(circlize)
library(dplyr)
# remotes::install_github("andrewsali/shinycssloaders", ref="8779ff0f0ad32b0731c06067e35fa65d85f66a89")
# remotes::install_github("andrewsali/shinycssloaders", ref="9565546494f3395a257546312313929ec0bbf968")
library(shinycssloaders)
library(stringr)
library(fs)
library(rmarkdown)
library(markdown)
library(data.table)
library(wesanderson)

# install complexheatmap from bioconductor - NOT CURRENTLY WORKING
library(BiocManager)
options(repos = BiocManager::repositories())
library(ComplexHeatmap)

# > call source function ====
source("my_circos_plot.R")
source(file.path("helpers", "Output_main.R"))

#------------------------------------------------------------------------------#

ui <- navbarPage(
    title = "",
    theme = shinytheme("flatly"),
    fluid = TRUE,
    selected = "MR Viz",
    inverse = FALSE,
    
  # MR Viz ====
    tabPanel(
      title = "MR Viz",
      mr_viz()),
  
  # HOME ====
  tabPanel(
    title = "Home",
    fluidRow(
      column(12, title = "", id = "home_home", home_home()),
      column(5, title = "About", id = "home_about", home_about()),
      column(4, title = "Example", id = "home_example", home_example()),
      column(3, title = "", id = "home_footer", home_footer())
    )),
  
  # HOW TO ====
  tabPanel(
    title = "How to",
    fluidRow(
      column(4, title = "", id = "how_to_1", how_to_1()),
      column(4, title = "About", id = "how_to_2", how_to_2()),
      column(4, title = "Example", id = "how_to_3", how_to_3()),
    )),
    
  # ANALYSIS ====
  tabPanel(
    title = "Analysis",
    tabsetPanel(
      id = 'dataset',
      ## UPLOAD YOUR DATA ====
      tabPanel(titlePanel(h5("Data")),
               sidebarLayout(
                 ## > sidebar panel ====
                 sidebarPanel(
                   h4("Upload data:"),
                   helpText("tab seperated; header = TRUE"),
                   
                   fileInput(
                     inputId = "file1",
                     label = "Track 1",
                     multiple = FALSE,
                     accept = c(
                       "text/csv",
                       "text/comma-separated-values",
                       "text/plain",
                       ".csv")),
                   
                   fileInput(
                     inputId = "file2",
                     label = "Track 2",
                     multiple = FALSE,
                     accept = c(
                       "text/csv",
                       "text/comma-separated-values",
                       "text/plain",
                       ".csv")),
                   
                   fileInput(
                     inputId = "file3",
                     label = "Track 3",
                     multiple = FALSE,
                     accept = c(
                       "text/csv",
                       "text/comma-separated-values",
                       "text/plain",
                       ".csv"))),
                 
                 ## > main panel ====
                 mainPanel(
                   tabsetPanel(
                     
                     tabPanel("Track 1",  
                              conditionalPanel(
                                condition = "output.file_imported",
                                h4("Description of uploaded data"),
                                textOutput("rowcount"),
                                textOutput("colcount"),
                                br(),
                                h4("First rows of uploaded data"),
                                tableOutput(outputId = "data1"),
                                br(),
                                h4("Volcano plot of uploaded data"),
                                plotlyOutput("volcanoplot1"))),
                     
                     tabPanel("Track 2",  
                              conditionalPanel(
                                condition = "output.file_imported2",
                                h4("Description of uploaded data"),
                                textOutput("rowcount2"),
                                textOutput("colcount2"),
                                br(),
                                h4("First rows of uploaded data"),
                                tableOutput(outputId = "data2"),
                                br(),
                                h4("Volcano plot of uploaded data"),
                                plotlyOutput("volcanoplot2"))),
                     
                     tabPanel("Track 3",  
                              conditionalPanel(
                                condition = "output.file_imported3",
                                h4("Description of uploaded data"),
                                textOutput("rowcount3"),
                                textOutput("colcount3"),
                                br(),
                                h4("First rows of uploaded data"),
                                tableOutput(outputId = "data3"),
                                br(),
                                h4("Volcano plot of uploaded data"),
                                plotlyOutput("volcanoplot3")))
                     ) # close tabsetPanel()
                   ) # close mainPanel()
                 ) # close sidebarLayout()
               ), # close tabPanel()
      
      ## PLOT PARAMETERS ====
      tabPanel(titlePanel(h5("Plot")),
               sidebarLayout(
                 ## > sidebar panel ====
                 sidebarPanel(
                   
                   h4("Circos plot paramaters"),
                   
                   selectInput("track_number",
                               "Number of tracks",
                               choices = c(1,2,3),
                               selected = 1),
                   
                   selectInput("label_column",
                               "Label:",
                               choices="", 
                               selected = ""),
                   
                   selectInput("section_column",
                               "Group:",
                               choices="",
                               selected = ""),
                   
                   selectInput("estimate_column",
                               "Estimate:",
                               choices="",
                               selected = ""),
                   
                   selectInput("pvalue_column",
                               "P-value:",
                               choices="",
                               selected = ""),
                   
                   selectInput("confidence_interval_lower_column",
                               "Lower confidence interval:",
                               choices="",
                               selected = ""),
                   
                   selectInput("confidence_interval_upper_column",
                               "Upper confidence interval:",
                               choices="",
                               selected = ""),
                   
                   numericInput("pvalue_adjustment",
                                "P-value adjustment:",
                                value = 1,
                                min = 1,
                                max = 999999),
                   
                   textOutput("pval"),
                   
                   ## Legend paramaters
                   h4("Legend paramaters"),
                   
                   radioButtons(
                     inputId = 'legend',
                     label = 'Legend',
                     choices = c(
                       Yes = 'TRUE',
                       No = 'FALSE'),
                     selected = 'FALSE'),
                   
                   textInput("track2_label",
                             "Track 2 legend label",
                             value = "Example1"),
                   
                   textInput("track3_label",
                             "Track 3 legend label",
                             value = "Example2"),
                   
                   textInput("track4_label",
                             "Track 4 legend label",
                             value = "Example3"),
                   
                   textInput("pvalue_label",
                             "P-value threshold label",
                             value = "P > 123"),
                   
                   textOutput("pval_label"),
                   
                   br(),
                   
                   h4("Customisation"),
                   
                   radioButtons(
                     inputId = 'colours',
                     label = 'Colour',
                     choices = c(
                       'Accessible colours' = 'TRUE',
                       'Not accessible colours' = 'FALSE'),
                     selected = 'TRUE'),
                   
                   actionButton("circosbutton","Plot")
                   ), # close sidebarPanel() 
                 
                 ## > main panel ====
                 mainPanel(withSpinner(uiOutput("pdf")))
                 ) # close sidebarLayout()
               ) # close tabPanel()
      ) # cose tabsetPanle()
    ), # close tabPanel
  
  # ABOUT  ====
  tabPanel(
    title = "About",
    fluidRow(
      column(4, title = "", id = "about_about", about_about()),
      column(4, title = "", id = "about_acknowledgements", about_acknowledgements()),
      column(4, title = "", id = "about_updates", about_updates())
      ) # close fluidRow()
    ), # close tabPanel()


  ## Keep shiny app awake ====
  tags$head(
    HTML(
      "
      <script>
      var socket_timeout_interval
      var n = 0
      $(document).on('shiny:connected', function(event) {
      socket_timeout_interval = setInterval(function(){
      Shiny.onInputChange('count', n++)
      }, 15000)
      });
      $(document).on('shiny:disconnected', function(event) {
      clearInterval(socket_timeout_interval)
      });
      </script>
      "
    )
    ),
  textOutput("")
  )





