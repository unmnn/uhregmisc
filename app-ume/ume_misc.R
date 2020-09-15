library(tidyverse)
# remotes::install_github("unmnn/uhregmisc")
library(uhregmisc)
library(shiny)
library(shinyWidgets)
library(shinyFeedback)
library(shinyjs)

if("data.rds" %in% dir(here("app-ume"))) {
  df <- read_rds(here("app-ume", "data.rds"))
} else {
  source(here("app-ume", "ume_prep-data.R"), encoding = "UTF-8")
}

