library(shiny)
library(ggplot2)
library(shinythemes)
library(DT)
library(plotly)


ui <- fluidPage(
  theme = shinytheme("flatly"),
  
  titlePanel(h1("HR Employee Attrition Prediction Dashboard", style = "color: #0073e6; font-weight: bold; text-align: center;")),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload CSV Dataset", 
                accept = c("text/csv", "text/comma-separated-values", ".csv")),
      
      verbatimTextOutput("debugFile"),
      
      div(style="border: 1px solid #ccc; padding: 10px; border-radius: 5px; background-color: #f9f9f9;",
          h4("Instructions for HR:"),
          p("1. The dataset must be in .csv format."),
          p("2. Required columns: Age, Attrition, Department."),
          p("3. Click 'Generate Predictions' to analyze the data."),
          p("4. Download report for further insights.")),
      
      actionButton("predict", "Generate Predictions", class = "btn btn-primary"),
      actionButton("reload", "Reload Page", class = "btn btn-danger", onclick = "location.reload();"),
  
      hr(),
      
      selectInput("department", "Filter by Department:", choices = NULL, selected = NULL, multiple = TRUE),
    
      sliderInput("age", "Filter by Age:", min = 18, max = 60, value = c(18, 60))
    ),
    
    
    mainPanel(
      tabsetPanel(
        tabPanel("Data Preview", DTOutput("dataTable")),
        tabPanel("Visualization", plotlyOutput("attritionPlot"), uiOutput("summary"))
      )
    )
  )
)

server <- function(input, output, session) {
  
  output$debugFile <- renderPrint({
    if (is.null(input$file)) return("No file uploaded yet")
    str(input$file)
  })
  
  
  dataset <- reactive({
    req(input$file)
    
    tryCatch({
      df <- read.csv(input$file$datapath, stringsAsFactors = FALSE)
      
      required_cols <- c("Age", "Attrition", "Department")
      missing_cols <- setdiff(required_cols, names(df))
      
      if (length(missing_cols) > 0) {
        stop(paste("Missing columns:", paste(missing_cols, collapse = ", ")))
      }
      
      df$Attrition <- as.factor(df$Attrition)
      
      updateSelectInput(session, "department", choices = unique(df$Department), selected = unique(df$Department))
      
      return(df)
    }, error = function(e) {
      print(paste("Error reading file:", e$message))
      return(NULL)
    })
  })
  
  
  filtered_data <- reactive({
    req(dataset())
    df <- dataset()
    
    if (!"Department" %in% names(df) || !"Age" %in% names(df)) {
      return(data.frame())
    }
    
    df <- df[df$Department %in% input$department & df$Age >= input$age[1] & df$Age <= input$age[2], ]
    df
  })
  
  
  
  output$dataTable <- renderDT({
    req(filtered_data())
    datatable(filtered_data(), options = list(pageLength = 5))
  })
  
  
  
  output$attritionPlot <- renderPlotly({
    req(input$predict)
    df <- filtered_data()
    validate(need(nrow(df) > 0, "No data available for visualization"))
    
    
    
    p <- ggplot(df, aes(x = Age, fill = Attrition)) +
      geom_histogram(binwidth = 5, position = "stack") +
      labs(title = "Employee Attrition by Age", x = "Age", y = "Count") +
      scale_fill_manual(values = c("#0073e6", "#ff69b4"))
    ggplotly(p)
  })
  
  output$summary <- renderUI({
    req(input$predict)
    HTML("<h4>Summary of Insights:</h4>",
         "<p><b>High Attrition Risk:</b> Employees in Sales & Marketing with low experience.</p>",
         "<p><b>Low Attrition Risk:</b> Employees with high salary & job satisfaction.</p>")
  })
  
  
}

# UI.R --------------------------------------------------------------------


shinyApp(ui = ui, server = server)