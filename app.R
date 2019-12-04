

if(!require('rsconnect')){install.packages('rsconnect')}
library(rsconnect)
library(shiny)
source("propublica.R")
source("app_server.R")
source("app_ui.R")


shinyApp(ui = ui, server = server)
