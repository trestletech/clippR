library(shiny)
library(shinyClip)

#' Define UI for application that demonstrates a simple Tree editor
#' @author Jeff Allen \email{jeff@@trestletech.com}
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Clip"),

    sidebarPanel(
      sliderInput("slider", "Slider:", 0, 100, 1),
      helpText(HTML(""))
    ),
    mainPanel(
      # Show a simple table.
      clippyOutput("clip")
    )
  ))
