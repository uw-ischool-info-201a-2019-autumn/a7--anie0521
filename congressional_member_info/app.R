

library(rsconnect)
library(shiny)
source("propublica.R")
rsconnect::setAccountInfo(name='assignment7byjisukim', token='3DA5053429116F13F6BCD66152F290B8', secret='2hYWW5F6Z4vYOXFmmf/O7QqAgLQ+cGJ56xRXCNl+')


shinyApp(ui = ui, server = server)
