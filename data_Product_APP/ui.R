library(shiny)

shinyUI(fluidPage(
  titlePanel("Wine Quality Regression Analysis"),
  sidebarLayout(
    sidebarPanel(
      helpText(
        h2("App Documentation"),
        p('This Shiny app aims to demonstrate simple linear regression analysis of data from Wine Quality Data Set taken from http://archive.ics.uci.edu/ml/datasets/Wine+Quality, in which relationship between outcome wine quality and a reactive parameter is determined by ploting the regression line according to the parameter the user selects'),
        p('Two datasets are included, related to red and white vinho verde wine samples, from the north of Portugal. The goal is to model wine quality based on physicochemical tests'),
        p('In the end, users can select the output format to export the results as PDF, HTML or Word file.'),
        strong('See http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality.names for more details of data set'),
        em('Refer to http://shiny.rstudio.com/gallery/download-knitr-reports.html for download feature')
        ),
      selectInput('parameters','Please select a regression model of wine quality against:',choices=names(redwine),selected=(names(redwine))[11]),
      selectInput('WineType', 'Select Wine Type', c('Red Wine', 'White Wine'),selected='Red Wine'),
      radioButtons('format', 'Document format', c('PDF', 'HTML', 'Word')),
      downloadButton('downloadReport','download')
    ),
    mainPanel(
      h2("Linear Regression Line"),
      plotOutput('regPlot'),
      h2("Summary of the model"),
      verbatimTextOutput("text1")
    )
  )
))