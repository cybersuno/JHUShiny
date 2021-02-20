#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    fit <- reactive({
        yVar <- input$dimY_id
        xVar <- input$dimX_id
        formula<-paste(yVar,"~",xVar)
        lm(as.formula(formula),data=mtcars)
    })
    
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        yVar <- input$dimY_id
        xVar <- input$dimX_id

        intercept<-summary(fit()$coefficients)[1]

        plot(mtcars[,xVar],mtcars[,yVar],xlab=xVar,ylab=yVar)
        abline(fit())

    })
    output$summY <- renderTable({
        yVar <- input$dimY_id
        xVar <- input$dimX_id
        summary(yVar)
    })
    
    output$summModelHeader <- renderTable({
        tab<-summary(fit())$coefficients
        tab$title<-""
        tab$title[1]<-"Intercept"
        tab$title[2]<-"Slope"
        tab
    })
    
    output$summModel <- renderTable({
        yVar <- input$dimY_id
        xVar <- input$dimX_id
        if (yVar!=xVar) {
            tab<-summary(fit())$coefficients
            #tab<-rbind(colnames(tab),tab)
            #tab<-cbind(rbind(rownames(tab)[1],rownames(tab)[2]),
            #           tab)
            tab<-cbind(rbind(rownames(tab)[1],rownames(tab)[2]),tab)
            tab
        }
        else {
            tab<-"Y and X are the same variable"
            tab
        }
    })

})
