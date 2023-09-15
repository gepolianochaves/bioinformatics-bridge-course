library(shiny)

ui <- fluidPage(
  column(6,
         
         fluidRow(
           column(6, 
                  sliderInput("MeasA_L", label = "Measure A lower bound:",
                              min=2, max=9, value=3, step=0.1)
           ), 
           column(6, 
                  sliderInput("MeasA_U", label = "Measure A upper bound:",
                              min=2, max=9, value=8, step=0.1)
           )
         ),
         fluidRow(
           column(6, 
                  sliderInput("MeasB_L", label = "Measure B lower bound:",
                              min=2, max=9, value=3, step=0.1)
           ), 
           column(6, 
                  sliderInput("MeasB_U", label = "Measure B upper bound:",
                              min=2, max=9, value=8, step=0.1)
           )
         )
)
 )


library(shiny)

server <- function(input, output) {}

# View App
shinyApp(ui, server)
