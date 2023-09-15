library(shiny)

variant <- "23063_BP"

df_regions <- readRDS("../data/df_regions.rds")

myplot <- function(){
  region_period_lineplot <- ggline(
    df_regions, x = "year_month", y = variant, 
    # Color the region
    color = "region", 
    # Choose the type of shape to use with the line
    linetype = c("longdash"),# "dashed","dotted", "dotdash"),
    # Choose line colors
    palette = c("#0412d4", "#a304d4", "#f71105", "#04d419"),
  )
  return(region_period_lineplot)
}

ui <- fluidPage()

server <- function(input, output) {
  output$hist <- renderPlot({
    hist(rnorm(input$num))
  })
}

shinyApp(ui=ui, server = server)