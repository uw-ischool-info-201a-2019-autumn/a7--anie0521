#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
source("propublica.R")

server <- function(input, output) {
   # it returns the data table of representatives through a user-interface state
    output$state_table <- renderDataTable({
        call_rep_info(input$state)
        
    })
    
    # it returns the detailed data table of a representative through a user-interface member full name
    output$member_table <- renderTable({
        member_info %>%
          filter(full_name == input$member_name)
    })
    
    # it returns the horizontal bar chart for gender through a user-interface state
    output$gender_plot <- renderPlot({
      ggplot(data = gender_summary(input$gender_state), aes(x = gender, y = number_of_representatives, fill = gender)) +
        geom_bar(stat = "identity") +
        coord_flip() 
    })
    
    # it returns the horizontal bar chart for party through a user-interface state
    output$party_plot <- renderPlot({
      ggplot(data = party_summary(input$gender_state), aes(x = party, y = number_of_representatives, fill = party)) +
        geom_bar(stat = "identity") +
        coord_flip()
    })
    
}
