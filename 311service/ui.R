sidebar <- dashboardSidebar(
  sidebarUserPanel("by Chaoran",
                   image = "1.jpg"),
  sidebarMenu(
    menuItem("Map", tabName = "map", icon = icon("map")),
    menuItem("Data", tabName = "data",icon = icon("database")
            ),
    selectizeInput("selected",
                   "Select Borough",
                   Borchoice)
  ))

body <-  dashboardBody(
  tabItems(
    tabItem(tabName = "map",
          fluidRow(box(dateInput("date",label = "Date",
                    value = "1/1/2018"),
                    format="%m/%d/%Y")),

          fluidRow(
            tabBox(
              id="tab1",height="600px",width ="1250px",
              tabPanel(
                "Map",
                leafletOutput("mymap",width = 1250,height = 590)
              ),
              tabPanel(
                "Chart",
                box(htmlOutput("hist1"),width=12),
                box(htmlOutput("pie1"),width=6),
                box(htmlOutput("pie2"),width=6)
              )
              )
            )
          ),
    tabItem(tabName = "data",
            fluidRow(box(dateRangeInput("daterange",
                           "Date Range",
                           start = "1/1/2018",
                           end = "1/7/2018",
                           min = "1/1/2018",
                           max = "1/31/2018",
                           format ="mm/dd/yyyy"
                          ))),
            fluidRow(
                    tabBox(
                    id="tab2",height="600px",width ="1250px",
                    tabPanel(
                        "Data Form",
                        box(DT::dataTableOutput("table"), width = 12)
                      
                         ),
                    tabPanel(
                        "Chart",
                        box(htmlOutput("line1"),width=12,height="500px")
                         )
                       )
                     )      
                    )
  )
)


dashboardPage(
  dashboardHeader(title = "NYC 311 services information",titleWidth = 420),
  sidebar,
  body
)




