#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(scatterplot3d)
        
dataset <- trees
names(dataset)<-c("Girth (cm)","Height (cm)","Volume (ft^3)")


pageWithSidebar(
        
        headerPanel("Trees Explorer"),
        
        sidebarPanel(
                
                sliderInput('sampleSize', 'Sample Size (slide the bar to explore the tree data)', min=10, max=nrow(dataset),
                            value=min(1, nrow(dataset)), step=1, round=0),
                
                selectInput('x', 'X', names(dataset)[[1]]),
                selectInput('y', 'Y', names(dataset)[[2]]),
                selectInput('z', 'Z', names(dataset)[[3]])
        ),
        
        mainPanel(
                tabsetPanel(type = "tabs",
                tabPanel("Sample Data",verbatimTextOutput("sample")),            
                tabPanel("Model Summary", verbatimTextOutput("summary")),
                tabPanel("3D plot",plotOutput('3D plot'))
                )
        )
)