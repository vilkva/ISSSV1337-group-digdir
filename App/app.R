# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#Definerer user interface
ui <- fluidPage(
                
    
    titlePanel("Risk Assesment For Public Business Entities"),
    
    fluidRow(
        
        column(3, 
              checkboxGroupInput("checkGroup", 
                                 h3("Checkbox group"), 
                                  choices = list("Helse" = 1, 
                                                 "Transport" = 2, 
                                                 "Elektrisitet og Vannkraft" = 3),
                                  
        
          )
        ),
    
    ),
   
   sidebarLayout(
     sidebarPanel(
       selectInput("var",
                   label = "Choose a sector to display",
                   choices = c("Table for passenger transport business entities", "Table for goods transport business entities",
                               "Table for air transport"), selected = "Table for passenger transport business entities")
     ),
     mainPanel(
       textOutput("selected_var")
     )
   )
)
 #   )
    
#)

#Definerer server logic
server <- function(input, output){
  data_input <- reactive({
    getSymbols(input$symb, src = "Brønnøysundregisteret",
               from = input$checkGroup[1], to = input$checkgroup[3],
               autoassign = FALSE)
  })
  
  output$table <- renderTable(
    data <- data_input()
    
  )
  }


#Kjør app
shinyApp(ui = ui, server = server)



###################################---KLADD---###################################
# output$df <- renderTable({
   #     "Table"
   # })
#}

#Kjør app
#shinyApp(ui = ui, server = server)

#--------------Example from R-----------

    # Application title
 #   titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
  #  sidebarLayout(
   #     sidebarPanel(
    #        sliderInput("bins",
     #                   "Number of bins:",
      #                  min = 1,
       #                 max = 50,
        #                value = 30)
    #    ),

        # Show a plot of the generated distribution
     #   mainPanel(
      #     plotOutput("distPlot")
    #    )
#    )
#)

# Define server logic required to draw a histogram
#server <- function(input, output) {

  #  output$distPlot <- renderPlot({
   #     # generate bins based on input$bins from ui.R
    #    x    <- faithful[, 2]
     #   bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
      #  hist(x, breaks = bins, col = 'darkgray', border = 'white',
       #      xlab = 'Waiting time to next eruption (in mins)',
        #     main = 'Histogram of waiting times')
#    })
#}

# Run the application 
#shinyApp(ui = ui, server = server)
