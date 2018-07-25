#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny);library(openfda);library(DT);library(ggplot2)
# Define UI for application that draws a histogram
shinyUI(
  

navbarPage("Data from  FDA Adverse Event Reporting System (FAERS)",
           tabPanel("Reactions",
                    sidebarLayout(
                      sidebarPanel(
                        p("Enter",strong("generic name "),"of the drug and select ",strong("sex"),".") ,
                        textInput("drug1", "Generic Name", "lurasidone"),
                        selectInput("sex1", "Sex:",
                                    c("Male" = "Male",
                                      "Female" = "Female",
                                      "Unknow" = "Unknow")),
                        p("Data are pre-filtered to show only the suspected case")
                      ),
                      mainPanel(
                        DT::dataTableOutput('table1'),
                        br(),
                        p(strong("Note: "), "Realtime data are from the FDA Adverse Event Reporting System (FAERS)")
                      )
                    )
           ),

           tabPanel("Indications",
                    sidebarLayout(
                      sidebarPanel(
                        p("Enter",strong("generic name "),"of the drug and select ",strong("sex"),".") ,
                        textInput("drug2", "Generic Name", "lurasidone"),
                        selectInput("sex2", "Sex:",
                                    c("Male" = "Male",
                                      "Female" = "Female",
                                      "Unknow" = "Unknow")),
                        p("Data are pre-filtered to show only the suspected case")
                      ),
                      mainPanel(
                        DT::dataTableOutput('table2'),
                        br(),
                        p(strong("Note: "), "Realtime data are from the FDA Adverse Event Reporting System (FAERS)")
                      )
                    )
           ),
           tabPanel("Death",
                    sidebarLayout(
                      sidebarPanel(
                        p("Enter",strong("generic name "),"of the drug.") ,
                        textInput("drug3", "Generic Name", "lurasidone"),
                        p("Data are pre-filtered to show only the suspected case")
                      ),
                      mainPanel(
                        plotOutput ('plot1'),
                        br(),
                        p(strong("Note: "), "Realtime data are from the FDA Adverse Event Reporting System (FAERS)")
                      )
                    )
           ),
           tabPanel("Age",
                    sidebarLayout(
                      sidebarPanel(
                        p("Enter",strong("generic name "),"of the drug.") ,
                        textInput("drug4", "Generic Name", "lurasidone"),
                        p("Data are pre-filtered to show only the suspected case")
                      ),
                      mainPanel(
                        plotOutput ('plot2'),
                        br(),
                        p(strong("Note: "), "Realtime data are from the FDA Adverse Event Reporting System (FAERS)")
                      )
                    )
           )

)
)
