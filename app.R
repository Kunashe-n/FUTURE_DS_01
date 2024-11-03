ui <- fluidPage(
  titlePanel("Salary Prediction Model"),
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Age:", min = 0, max = 100, value = 30),
      selectInput("workclass", "Work Class:", choices = levels(who_data$workclass)),
      numericInput("fnlwgt", "Final Weight:", value = 100000),
      selectInput("education", "Education:", choices = levels(who_data$education)),
      numericInput("education_no_of_years", "Years of Education:", value = 12),
      selectInput("marital_status", "Marital Status:", choices = levels(who_data$marital_status)),
      selectInput("occupation", "Occupation:", choices = levels(who_data$occupation)),
      selectInput("race", "Race:", choices = levels(who_data$race)),
      selectInput("sex", "Sex:", choices = levels(who_data$sex)),
      numericInput("capital_gain", "Capital Gain:", value = 0),
      numericInput("capital_loss", "Capital Loss:", value = 0),
      numericInput("working_hours_per_week", "Working Hours per Week:", value = 40),
      selectInput("native_contienent", "Native Contienent:", choices = levels(who_data$native_contienent)),  # Corrected spelling
      actionButton("predict", "Predict Salary")
    ),
    mainPanel(
      textOutput("prediction")  # Added output element
    )
  )
)


# Server Logic
server <- function(input, output) {
  observeEvent(input$predict, {
    new_data <- data.frame(
      age = input$age,
      workclass = factor(input$workclass, levels = levels(who_data$workclass)),
      fnlwgt = input$fnlwgt,
      education = factor(input$education, levels = levels(who_data$education)),
      education_no_of_years = input$education_no_of_years,
      marital_status = factor(input$marital_status, levels = levels(who_data$marital_status)),
      occupation = factor(input$occupation, levels = levels(who_data$occupation)),
      race = factor(input$race, levels = levels(who_data$race)),
      sex = factor(input$sex, levels = levels(who_data$sex)),
      capital_gain = input$capital_gain,
      capital_loss = input$capital_loss,
      working_hours_per_week = input$working_hours_per_week,
      native_contienent = factor(input$native_contienent, levels = levels(who_data$native_contienent))  # Corrected spelling
    )
    
    prediction <- predict(model, new_data)
    output$prediction <- renderText({
      paste("Predicted Salary Class:", prediction)
    })
  })
}
# Run the Application
shinyApp(ui = ui, server = server)
