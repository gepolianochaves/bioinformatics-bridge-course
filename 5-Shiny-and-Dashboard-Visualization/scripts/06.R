library(shiny)
library(dplyr)
library(ggplot2)
library(ggpubr)

data <- df_regions
data <- df_regions_melted

ui <- fluidPage(
  
  fluidRow(
    column(3,
           selectInput(inputId = "country",
              label = "Choose a Geographic Region",
              choices = unique(data$region),
              width = "200"
              )
           ),
    column(3,
           selectInput(inputId = "mutation",
                     label = "Choose a Mutation",
                     choices = unique(data$variable),
                     width = "200"
                     )
           ),
    column(3,
           selectInput(inputId = "country",
                       label = "Choose a Year",
                       choices = unique(data$year),
                       width = "200"
           )
  ),
  plotOutput("lineCountry"),
  
  
  selectInput(inputId = "mutation", 
              label = "Choose a Variant", 
              choices = unique(data$variable),
              width = "200"
              ),
  plotOutput("lineMutation"),
  
  
  selectInput(inputId = "year",
              label = "Choose a Year",
              choices = unique(data$year),
              width = "200"
              ), 
  plotOutput("linePeriod"),
  
  
)
)

server <- function(input, output) {
  output$lineCountry <- renderPlot({
    
    # Filter Region based on UI
    data <- data[ which(
        data$region == input$country
      ), ]
    
    # Filter  Mutation based on UI
    data <- data[ which(
      data$variable == input$mutation
    ), ]
    
    # Filter  Mutation based on UI
    data <- data[ which(
      data$year == input$year
    ), ]
    
    # Original ggline script
    ggline(
      data, x = "year_month", y = "value",
      # Color the region
      color = "region",
      # Choose the type of shape to use with the line
      linetype = c("longdash"),# "dashed","dotted", "dotdash"),
      # Choose line colors
      palette = c("#0412d4", "#a304d4", "#f71105", "#04d419"),
    )
  })
}

# View App
shinyApp(ui, server)