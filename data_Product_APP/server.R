library(shiny)
library(shinyapps)
library(ggplot2)
library(knitr)
setwd("C:/Users/D062420.GLOBAL/Documents/R WS/data_Product_APP/")
source("helper.R")


shinyServer(function(input, output) {
  
  output$text1 <- renderPrint( 
    if(input$WineType=='Red Wine') summary(lm(regFormula(),data=redwine))
    else summary(lm(regFormula(),data=whitewine))
  )
  
  regFormula <- reactive({
    as.formula(paste('quality ~',input$parameters))
  })
  
  output$regPlot <- renderPlot({
    par(mar = c(4, 4, .1, .1))
    if(input$WineType=='Red Wine'){
      #sp <- ggplot(redwine, aes(x=input$parameters, y=redwine$quality))+ geom_point()
      #print(sp)
      plot(regFormula(), data = redwine, pch = 19,xlab=input$parameters,ylab='Wine Quality')
      m<-lm(regFormula(),data=redwine)
      abline(m,col='red')
    }
    else {
      plot(regFormula(), data = whitewine, pch = 18,xlab=input$parameters,ylab='Wine Quality')
      m<-lm(regFormula(),data=whitewine)
      abline(m,col='blue')
    }
  })
  
  output$downloadReport <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
      ))
    },
    
    content = function(file) {
      src <- normalizePath('report.Rmd')
      
      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report.Rmd')
      
      library(rmarkdown)
      out <- render('report.Rmd', switch(
        input$format,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
    }
  )
  
})