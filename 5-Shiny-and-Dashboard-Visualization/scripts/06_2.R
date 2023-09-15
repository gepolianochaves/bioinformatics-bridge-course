library(shiny)
library(dplyr)
library(ggplot2)

library(ggpubr)

variant <- "B23063_BP"
data <- readRDS("./data/df_regions.rds")

ui <- fluidPage(
  selectInput(inputId = "region", 
              label = "Choose a Country", 
              choices = unique(data$region)), 
  plotOutput("line")
)

server <- function(input, output) {
  output$line <- renderPlot({
    
    # ggplot(data %>% filter(region == input$region), 
    #        aes(year_month, `23063_`, 
    #            color = region, group = region
    #            )) + geom_line()
    
    # Filter the DF based on the User input
    data <- data[
      which(data$region == input$region),]
    
    # Call figure plot function
    ggline(
      data, x = "year_month", y = variant, 
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
