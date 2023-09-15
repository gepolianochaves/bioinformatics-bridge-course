library(shiny)
library(dplyr)
library(ggplot2)
library(ggpubr)

# Descriptor: included the titlePanel, SidebarLayout ans sidebarPanel functions
# Used this reference link:
# https://shiny.rstudio.com/articles/layout-guide.html

variant <- "B23063_BP"
df_regions <- readRDS("../data/df_regions.rds")

data <- df_regions

data <- df_regions_melted

ui <- fluidPage(
  
  fluidRow(
    column(3,
           selectInput(inputId = "NotSure",
                       label = "Heatmap",
                       choices = unique(df_community_raw),
                       width = "200"
           )
    ),
    column(3,
           selectInput(inputId = "country",
              label = "Region",
              choices = unique(data$region),
              width = "200"
              )
           ),
    column(3,
           selectInput(inputId = "year",
                     label = "Year",
                     choices = unique(data$year),
                     width = "200"
                     )
           ),
    column(3,
           selectInput(inputId = "mutation",
                       label = "Variant Position",
                       choices = unique(data$variable),
                       width = "200"
           )
  )
  ),
  plotOutput("heatmap"),
  plotOutput("lineCountry"),
  plotOutput("lineMutation"),
  plotOutput("linePeriod"),

)

server <- function(input, output) {
  
  output$heatmap <- renderPlot({
      pheatmap::pheatmap(df_community_raw)
    })
  
  output$lineCountry <- renderPlot({
    # # 1) Heatmap plot
    # pheatmap::pheatmap(df_community_raw)
    
    # 2) Frequency Plot (Line Plot)
    
    ### 2.1) Filter Region based on UI
    data <- data[ which(
        data$region == input$country
      ), ]
    
    ### 2.2) Filter  Mutation based on UI
    data <- data[ which(
      data$variable == input$mutation
    ), ]
    
    ### 2.3) Filter  Year based on UI
    data <- data[ which(
      data$year == input$year
    ), ]
    
    ### 2.4) Original ggline script (Plots the Line Graph)
    ggline(
      data, x = "year_month", y = "value",
      # Color the region
      color = "region",
      # Choose the type of shape to use with the line
      linetype = c("solid"),# "dashed","dotted", "dotdash", "longdash"),
      # Choose line colors
      palette = c("#0412d4", "#a304d4", "#f71105", "#04d419"),
    )
  })
}

# View App
shinyApp(ui, server)