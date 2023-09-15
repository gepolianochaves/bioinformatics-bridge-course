library(shiny)
library(datasets)

ui <- fluidPage(
  # Title
  titlePanel("Telephones by region"),
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("region", "Region:", 
                  choices=colnames(df_community)),
      hr(),
      helpText("Data from AT&T (1961) The World's Telephones.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("phonePlot")  
    )
    
  )
)


# Define a server for the Shiny app
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    
    # Render a barplot
    barplot(df_community[,input$region], 
            main=input$region,
            ylab="Number of Telephones",
            xlab="Year")
  })
}

shinyApp(ui = ui, server = server)