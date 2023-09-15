library(shiny) 
library(datasets)

df_community <- read.table("../data/df_community.txt")

ui <- fluidPage(
  # Give the page a title
  titlePanel("Frequency SARS-CoV-2 Mutations"),
  
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

server <- function(input, output) {
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    
    # Render a barplot
    barplot(df_community[,input$region], 
            main=input$region,
            ylab="SARS-CoV-2 Mutation Frequecy (%)",
            xlab="Year")
  })
} 

shinyApp(ui = ui, server = server)
