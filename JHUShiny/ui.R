#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Variable Analysis for mtcars"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            p("This application shows the linear relationship between variables in the mtcars dataset."),
            p("Everytime one of the two combos changes value, a new linear model is fitted to show the results"),
            selectInput("dimY_id","Y variable",choices=colnames(mtcars)),
            p("The above var is the var that is used as Y in the lm function and the values in the Y axis."),
            selectInput("dimX_id","Predictor",choices=colnames(mtcars),
                        selected=colnames(mtcars)[2]),
            p("The above variable is the predictor. This predictor is the right variable in the formula for lm and the values in the X axis "),
            p("The lm function is build as lm(Y ~ X)")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            #h1("Variable Analysis"),
            h2("Coefficients"),
            p("The following table returns the intercept and coefficients for the relation between Y and X vars"),
            #tableOutput("summY"),
            tableOutput("summModel"),
            h2("Plot"),
            p("The plot below has the X,Y values in points and the linear model in the line"),
            plotOutput("distPlot")
        )
    )
))
