source(file.path("data-raw", "uhreg.R"), encoding = 'UTF-8')
source(file.path("data-raw", "data_dict.R"), encoding = 'UTF-8')
devtools::document()
devtools::check()
devtools::install()
devtools::reload()
rmarkdown::render(input = "README.rmd",
                  output_options = list(html_preview = FALSE))
