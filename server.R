#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(scatterplot3d)


names(trees)<-c("Girth (cm)","Height (cm)","Volume (ft^3)")

function(input, output) {
        
        dataset <- reactive({
                trees[sample(nrow(trees),input$sampleSize),c(input$x,input$y,input$z)]
        })
        
        output$sample<-renderPrint({
                dt<-dataset()
                dt
        })
        
        output$summary<-renderPrint({
                dt<-dataset()
                fit <- lm(dt[,input$z] ~ dt[,input$x] + dt[,input$y])
                names(fit$coefficients) <- c("Intercept", input$x,input$y)
                summary(fit)
                
        })
        
       
        output$`3D plot` <- renderPlot({
               
               p <-scatterplot3d(dataset(), pch=16, angle = 60, col.axis = "blue",
                                 col.grid = "lightblue",color="deeppink",
                                 xlab = input$x, ylab = input$y, zlab = input$z, 
                                 main = "ScatterPlot3D") 
               #Add regression plane
               dt<-dataset()
               fit <- lm(dt[,input$z] ~ dt[,input$x] + dt[,input$y]) 
               p$plane3d(fit)
               print(p)
               
                
        }, height=700)
        
}

