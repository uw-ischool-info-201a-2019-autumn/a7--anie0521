

library(httr)
library(jsonlite)
library(stringr)
library(dplyr)
#setwd("~/Documents/GitHub/a7--anie0521")
source("propublica_key.R")


# All dataset
# This code is reading a big dataset from ProPublica API to check all State Representatives information. 

congress = "116"
chamber = "house"
query_params <- list(key = api_key)
base_url <- "https://api.propublica.org/congress/v1/"
endpoint <- paste0(base_url, congress, "/", chamber, "/members.json")
response <- GET(endpoint, add_headers("X-API-Key" = api_key))
response_text <- content(response, type = "text", encoding = "UTF-8")
response_data <- fromJSON(response_text)
response_all <- flatten(response_data$results)
all_members <- data.frame(response_all$members)

# state dataset
# This code is filtering by states to return only states name.
state_df <- all_members %>%
  group_by(state) %>%
  summarise()

# member ID dataset
# This code is filtering first namd and last name. 
# And, it creates full_name through combining first and last name to return State Representatives name. 

member_name_df <- all_members %>%
  mutate(full_name = paste(first_name, last_name)) %>%
  group_by(full_name) %>%
  summarise()


# function 1
# call_representative funciton is reading ProPublica API chamber = "house"
# and it creates data set to get representative's information.

call_representative <- function(chamber = "house", state) {
  query_params <- list(key = api_key)
  base_url <- "https://api.propublica.org/congress/v1/members"
  endpoint <- paste0(base_url, "/", chamber, "/", state, "/current.json")
  response <- GET(endpoint, add_headers("X-API-Key" = api_key))
  response_text <- content(response, type = "text", encoding = "UTF-8")
  response_data <- fromJSON(response_text)
  results_data <- as.data.frame(response_data$results)
  #return(results_data)
}

# This code returns the data table through selecting a state by the user.  

call_rep_info <- function(state ="WA") {
  df <- call_representative(chamber, state)
  rep_df <- df %>%
    mutate(full_name = paste(first_name, last_name)) %>%
    select(id ,full_name, party, twitter_id, facebook_account) %>%
    mutate(age = lapply(id, get_age)) %>%
    select(full_name, party, age, twitter_id, facebook_account)
}


# function 2
# call_memberid funciton is reading ProPublica API to create data set by member id.

call_memberid <- function(member_id) {
  query_params <- list(key = api_key)
  base_url <- "https://api.propublica.org/congress/v1/members"
  endpoint <- paste0(base_url, "/", member_id ,".json")
  response <- GET(endpoint, add_headers("X-API-Key" = api_key))
  response_text <- content(response, type = "text", encoding = "UTF-8")
  response_data <- fromJSON(response_text)
  results_data <- response_data$results
  #return(results_data)
}

# This code returns the data table which includes state, fullname, url, phone, office, and gender by member id.

member_info <- all_members %>%
  mutate(full_name = paste(first_name, last_name)) %>%
  group_by(state ,full_name, url, phone, office, gender) %>%
  summarise()


# function 3
# get_age function is calculating current representative's age with date of birth information from call_memberid function. 

get_age <- function(member_id) {
  df <- call_memberid(member_id)
  age <- floor(((Sys.Date() - as.Date(df$date_of_birth)) / 365.25))
  #return(as.integer(age))
}


# function 4
# gender_summary function is summarizing the data by user-input state.
# and it returns the ratio of gender representatives.

gender_summary <- function(state = "WA") {
  df <- call_representative(chamber, state) %>%
    group_by(gender) %>%
    summarise(number_of_representatives = n())
}

# party_summary function is summarizing the data by user-input state.
# and it returns the ratio of each party.

party_summary <- function(state = "WA") {
  df <- call_representative(chamber, state) %>%
    group_by(party) %>%
    summarise(number_of_representatives = n())
}

