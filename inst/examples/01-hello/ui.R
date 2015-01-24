library(shiny)
library(shinyClip)

#' Define UI for application that demonstrates a simple Tree editor
#' @author Jeff Allen \email{jeff@@trestletech.com}
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Shiny Helper"),

    sidebarPanel(
      selectInput("sel", "Select Widget Type:", c("Slider", "Text Input", "Date Picker"), selectize=FALSE),
      sliderInput("slider", "Slider:", 0, 100, 1),
      helpText(HTML(""))
    ),
    mainPanel(
      plotOutput("plot", clickId="plotClick"),
      clippyOutput("clip")
    )
  ))
