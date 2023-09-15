library(shiny)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(pheatmap)

# Descriptor: included the titlePanel, SidebarLayout ans sidebarPanel functions
# Used this reference link:
# https://shiny.rstudio.com/articles/layout-guide.html

data <- df_regions
data <- df_regions_melted

ui <- fluidPage(
  
  titlePanel("SARS-CoV-2 Mutation Clustering and Time Course Frequency"),
  
  sidebarLayout(
    sidebarPanel(
  
  fluidRow(
    column(4,
           numericInput(# This function was chosen based on the Code for the Iris k-means Clustering Dashboard
             'clusters', 
             'Region Cluster Count', 5, 
             min = 1, max = 10, 
             width = 200)
    ),
    column(4,
           numericInput(
             'clustersMutations', 
             'Mutation Cluster Count', 5, 
             min = 1, max = 10, 
             width = 200)
    ),
    column(4,
           selectInput(inputId = "country",
                       label = "Region",
                       choices = unique(data$region),
                       width = "200"
           )
    ),
    column(4,
           selectInput(inputId = "year",
                       label = "Year",
                       choices = unique(data$year),
                       width = "200"
           )
    ),
    column(4,
           selectInput(inputId = "mutation",
                       label = "Variant Position",
                       choices = unique(data$variable),
                       width = "200"
           )
    )
  )
  ),
  mainPanel(
  plotOutput("heatmap"),
  plotOutput("lineCountry"),
  )
  )
)


server <- function(input, output) {
  
  # clusters <- reactive({
  #    input$clusters
  # })
  
  # Define the type of correlation to be used in calculating the clustering distance
  # Lack of the dcols1 argument makes the Application to glitch
  drows1 <- "euclidean"
  dcols1 <- "euclidean"
  
  output$heatmap <- renderPlot({
    pheatmap(df_community_raw,
             cutree_cols = input$clusters, # The form of input for the number of clustes was chosen based on how the Title of Telephones by region Dashboard
             cutree_rows = input$clustersMutations, 
             color = col.pal,
             cellwidth = 5, cellheight = 6, scale = "none",
             treeheight_row = 200,
             kmeans_k = NA,
             show_rownames = T, show_colnames = T,
             #main = "Full heatmap (avg, eucl, unsc)",
             main = "Frequencies of SNP Variants of SARS-CoV-2",
             clustering_method = "average",
             cluster_rows = T, cluster_cols = T,
             clustering_distance_rows = drows1,
             fontsize_row = 10,
             fontsize_col = 10,
             clustering_distance_cols = dcols1,
             kmeans = 20)
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