#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# install.packages("shiny")

library(shiny)
library(reshape2)
library(htmltools)
library(shinythemes)
library(shinydashboard)
#source("propublica.R")


ui <- navbarPage("Assignment 7", theme = shinytheme("paper"),
                 
           # About page in shiny app
           # it returns few paragraphs in each sections
           tabPanel("About", 
                    mainPanel(h3("About"), 
                              
                    # Overview section 
                    h4("Overview"), 
                    p("Assignment 7 describes information on Congressional Representatives. 
                      The ", strong("about "), "page describes the brief summary about this shiny app."),

                    p("The ", strong("Info "), "page provides a user-interface that
                      allows the user to choose a state to check the information of the representative(s):
                      full name, party, age, twitter id, and Facebook account. Also, through selecting the name,
                      a table lists that state, full name, URL, phone, office, and gender."),

                    p("The ", strong("summary "), "page shows two horizontal bar charts categorized 
                      by gender and party which can be queried by a user by selecting a state."),
                    tags$a(href = "https://projects.propublica.org/api-docs/congress-api/", "ProPublica API"),

                    br(),
                    
                    # Affiliation section
                    h4("Affiliation"),
                    p("Jisu Kim, INFO-201A: Technical Foundations of Informatics, 
                      The Information School, University of Washington, Autumn 2019"), 
                    p(em("December 1, 2019")),

                    br(),
                    
                    # Refelctive statement section
                    h4("Reflective statement"), 
                    p("The most challenge part of this assignment was coding with the API and linking the codes to an online database.  
                      Previously, I have had practice coding and plugging in an actual data set and the API concept was still new to me. 
                      In order to overcome this challenge, I read more about the API concept in the textbook and on the internet, 
                      and also worked together with classmates. "),
                    
                    p("The second challenge was using three different APIs for each function as opposed to a single API to get information.
                      However, I solved this issue running test codes. In WMD, O'Neil said that when people work with big data, and
                      if they use it smartly, it is able to provide to us important insights(216). As O'Neil metioned, I was struggling using
                      big and multiple data from API, however, through creating funcitons for the data, I got the insight of my assignment.")
                    )), 
           # Info page
           # it includes user-interface to return data table
           tabPanel("Info",
                    h3("State Representatives query"),
                               sidebarPanel(
                        selectInput(
                          "state", "Select a state:",
                          c(state_df$state),
                          selected = "WA"
                        ), selectInput(
                          "member_name", "Select a representative's name: ",
                          c(member_name_df$full_name)
                        )
                        ),
                        mainPanel(
                          h4("Representatives Data Table"),
                          dataTableOutput("state_table")
                        ), mainPanel(
                          h4("Details"),
                          tableOutput("member_table"))), 
           # Summary page
           # it includes user-interface to return two bar charts categorized by gender and party
           tabPanel("Summary", 
                    h3("Summary"),
                      sidebarPanel(
                      selectInput("gender_state", "Select a state: ", c(state_df$state), selected = "WA")), 
                      mainPanel(h4("Bar chart by gender"), plotOutput("gender_plot"), 
                                h4("Bar chart by party"), plotOutput("party_plot"))
                      )
)
