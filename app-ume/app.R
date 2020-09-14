library(here)
source(here("app-ume", "ume_misc.R"))

ui <- fluidPage(
    useShinyFeedback(),
    useShinyjs(),
    tags$style("#enough_data {color: red;}"),
    titlePanel("UHREG Data Missingness"),

    sidebarPanel(
        pickerInput("visit_type", "Visit type(s):",
                    choices = levels(df$.visit_type),
                    selected = levels(df$.visit_type),
                    multiple = TRUE,
                    options = pickerOptions(
                        actionsBox = TRUE,
                        selectedTextFormat = "count > 3"
                    )),
        pickerInput("treatment_code", "Treatment(s):",
                    choices = levels(df$.treat_code),
                    selected = levels(df$.treat_code),
                    multiple = TRUE,
                    options = pickerOptions(
                        actionsBox = TRUE,
                        selectedTextFormat = "count > 3"
                    )),
        radioButtons("gender", "Gender(s):",
                     choices = c("all", "male", "female"),
                     inline = TRUE),
        sliderInput("age", "Age:",
                    min = min(df$.age, na.rm = TRUE),
                    max = max(df$.age, na.rm = TRUE),
                    value = range(df$.age, na.rm = TRUE)),
        radioButtons("q_order", "Questionnaire order (y-axis):",
                     choices = c("by mutual data missingness" = "1",
                     "fixed (alphabetically)" = "2"),
                     selected = "1"),
        actionButton("button", "Draw plot"),
        # hidden(span(textOutput("enough_data"), style="color:red"))
        hidden(textOutput("enough_data"))
    ),

    mainPanel(
        plotOutput("plot", width = "800px", height = "600px")
    )

)

server <- function(input, output, session) {

    observeEvent(input$button, {
        if(nrow(data_selection()) < 50) {
            show("enough_data")
        } else {
            hide("enough_data")
        }
    })

    output$enough_data <- renderText({
        paste0("Not enough data: only ", nrow(data_selection()), " rows match filter (50 required).")
    })



    observeEvent(is.null(input$visit_type), {
        if (is.null(input$visit_type)) {
            showFeedbackDanger(
                inputId = "visit_type",
                text = "Select at least 1 visit type."
            )
        } else {
            hideFeedback("visit_type")
        }
    })

    observeEvent(is.null(input$treatment_code), {
        if (is.null(input$treatment_code)) {
            showFeedbackDanger(
                inputId = "treatment_code",
                text = "Select at least 1 treatment code."
            )
        } else {
            hideFeedback("treatment_code")
        }
    })

    data_selection <- eventReactive(input$button, {
        data_selection <- df %>%
            filter(.visit_type %in% input$visit_type) %>%
            filter(.treat_code %in% input$treatment_code) %>%
            {if(!input$gender == "all") filter(., .gender %in% input$gender) else .} %>%
            filter(between(.age, input$age[1], input$age[2]))

        # browser()
        # req(nrow(data_selection) > 1)

        data_selection
    }, ignoreNULL = FALSE)

    data_plot <- reactive({
        req(nrow(data_selection()) > 50, cancelOutput = TRUE)
        df_miss <- data_selection() %>%
            select(-starts_with(".")) %>%
            mutate(across(everything(), is.na))

        mat_data <- as.matrix(df_miss)
        dist_inst = dist(mat_data)
        clu_inst = hclust(dist_inst)

        df_plot <- df_miss %>%
            rowid_to_column(var = "id") %>%
            mutate(id = factor(id, levels = id[clu_inst$order])) %>%
            pivot_longer(cols = c(-id), names_to = "item", values_to = "is_missing") %>%
            mutate(item = factor(item))

        if(isolate(input$q_order) == "1") {
            dist_item= dist(t(mat_data))
            clu_item = hclust(dist_item)
            df_plot <- df_plot %>%
                mutate(item = factor(item, levels = attr(dist_item, "Labels")[clu_item$order]))
        }

        return(df_plot)
    })

    output$plot <- renderPlot({

        df_plot <- data_plot()
        labels <- c(1, round(n_distinct(df_plot$id)/3 * c(1,2)),
                    n_distinct(df_plot$id)) %>%
            unique()
        breaks <- levels(df_plot$id)[labels]


        ggplot(df_plot, aes(x = id, y = item, fill = is_missing)) +
            coord_cartesian(expand = FALSE) +
            scale_x_discrete(breaks = breaks, labels = labels) +
            geom_raster() +
            geom_hline(data = tibble(yintercept = (1:length(levels(df_plot$item))) - 0.5),
                       aes(yintercept = yintercept), color = "white") +
            labs(x = "Recordings", y = NULL,
                 # title = paste0("Data missingness (", visit_type, ")"),
                 fill = NULL) +
            scale_fill_manual(values = c(`FALSE` = "royalblue", `TRUE` = "grey60"),
                              labels = c("available", "missing")) +
            theme_minimal(base_size = 24, base_family = "sans") +
            # theme(plot.title.position = "plot") +
            theme(plot.title = element_text(hjust = 0.5)) +
            theme(panel.grid.minor = element_blank()) +
            theme(panel.grid.major = element_blank()) +
            theme(axis.ticks.x = element_line()) +
            theme(legend.position = "top") +
            theme(legend.key.size = unit(1, "cm")) +
            theme(legend.margin = margin(0,0,-0.5,0, "cm")) +
            theme(plot.margin = margin(0.5,1,0.2,0.2,"cm"))
    })
}

# Run the application
# vwr = dialogViewer('MyAppName', width = 1600, height = 1200)
# runGadget(ui, server, viewer = vwr)
# runApp("ume")
shinyApp(ui = ui, server = server)

