library(shiny)



ui <- fluidPage(
sliderInput(inputId = "num",
            label = "Choose a Number",
            value = 25, min = 1, max = 100),
plotOutput("hist")
)


server <- function(input, output){
  output$hist <- renderPlot({
    title <- "100 Random Normal Values"
    hist(rnorm(input$num), main = title)
  })
}



shinyApp(ui = ui, server=server)
