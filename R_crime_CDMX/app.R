#Crimenes en la CDMX 
#By Ricardo Lastra

library(shiny)
library(leaflet)
library(dplyr)
library(shinythemes)
library(ggplot2)
library(ggthemes)
library(DT)



#Elegimos listas desplegables
vars <- unique(geodata$crime)

vars2 <- unique(geodata$year)

vars3 <- unique(cuadran2$municipio)

vars4 <- unique(cuadran2$crime)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#          UI            #-#-#-#-#-#-#-#-#-#-#-#-#-#-# 

ui <- fluidPage(theme = shinytheme("united"),
                
  navbarPage("Crímenes CDMX", 
             
             tabPanel("Mapa interactivo",
                      
                      div(class="outer",
                          
                          
                      leafletOutput("map"),
                      
                      h2("Explorador de Crímenes"),
                      
                      absolutePanel(id = "controls", #class = "panel panel-default", 
                                    fixed = TRUE, draggable = TRUE, top = 80, left = 80, right = "auto", 
                                    bottom = "auto", width = 300, height = "auto",
                                    
                                    
                                    selectInput("crimen", "Tipo de Crímen*", vars,
                                                selected = "ROBO DE VEHICULO AUTOMOTOR S.V."),
                                    br(),
                                    
                                    selectInput("periodo", "Año**", vars2,
                                                selected = 2016),
                                    
                                    
                                    
                                    
                                    helpText("*Basado en la clasificación de crímenes de la SSPDF", 
                                             "**Crímenes violentos y no violentos separados por año")
                                    
                                    
                                    
                                    ),
                      
                      fluidRow(column(4, verbatimTextOutput("value")),
                               column(2, verbatimTextOutput("value2")),
                               column(2, verbatimTextOutput("value3"))),
                      
                      tags$div(id="cite","Mapa creado para ITAM", tags$em("parte del proyecto de R para la clase de programming for ds"), 
                               "por RLC (Sep,2017).", textOutput("currentTime"))
                      )),
             
             tabPanel("Time Line",
                      
                      fluidRow(
                        column(12,
                               wellPanel(
                                 h2("Revisando Lineas de Tiempo"),
                                 
                                 h4("En esta sección podras ver los crimenes en los ultimos años en la ciudad de México"),
                                 
                                 br(),
                                 
                                 h5("Selecciona el municipio para ver la densidad de crimenes"),
                                 
                                 selectInput("municipio", "Municipio", vars3),
                                 
                                 br(),
                                 
                                 h5("Selecciona el tipo de crimen para ver el crecimiento/descenso en los ultimos años"),
                                 
                                 selectInput("crimen2", "Tipo de Crímen", vars4,
                                             selected = "ROBO DE VEHICULO AUTOMOTOR S.V.")
                                 
                                 
                               )
                        )
                        
                      ),
                      
                      fluidRow(plotOutput("plot")
                            
                            
                      ),
                      
                      fluidRow(column(4, verbatimTextOutput("value4")),
                               column(2, verbatimTextOutput("value5")),
                               column(4, verbatimTextOutput("value6")))
             ),
             
                      
                      
             tabPanel("Data Analytics",
                      fluidPage(
                        titlePanel("Análisis por tipo de delito"),
                        
                        br(),
                        
                        h5("Busca o selecciona los delitos que desees visualizar por sector en un año determinado"),
                        fluidRow(
                          column(4,
                                 selectInput("delito",
                                             "Tipo de delito:",
                                             c("Todos",
                                               unique(as.character(cuadran3$crime))))
                          ),
                          column(4,
                                 selectInput("sector",
                                             "Sector:",
                                             c("Todos",
                                               unique(as.character(cuadran3$sector1))))
                          ),
                          column(4,
                                 selectInput("anodel",
                                             "Año del delito:",
                                             c("Todos",
                                               unique(as.character(cuadran3$year))))
                          )
                        ),
                        fluidRow(
                          DT::dataTableOutput("table")
                        )
                      )
                      
                      
                      ),
             
             tabPanel("Contexto",
                      
                      fluidPage(
                        titlePanel("Resumen general"),
                       
                        
                        sidebarLayout(
                          
                          sidebarPanel(
                            
                            
                            radioButtons("munici", "Delegaciones CDMX", vars3, selected = "CUAUHTEMOC"),
                            
                            hr()
                            
                          ),
                          
                         
                          mainPanel(
                            
                            plotOutput("plot4"),
                            
                            h5("Una vez que hemos convivido con el Mapa interactivo, el Time Line y que se ha realizado
                               un análisis por tipo de delito, podemos observar cómo ha disminuido la frecuencia de
                               crímenes por año, así mismo el delito de Homicidio es el que mas debe preocupar, 
                               respecto al cumulo de delitos por Violación. 
                               To-Do: Se sugiere realizar índices de tasas por delito dándoles un valor o peso
                               respecto a la severidad o importancia, mostrando mapas y gráficos de zonas mas
                               violentas y menos violentas. Así mismo se propone integrar otras variables como 
                               ingreso per cápita, valor de los predios, % de población, índices de denuncias, entre otros;
                               mismos que podrán ser obtenidos de INEGI."),
                            
                            
                            
                            h6("*La aplicación realizada es un proyecto para el ITAM, 
                               se trató de usar las diferentes herramientas y dimensiones de los datos,
                               realizando previamente manipulación y análisis de los diferentes inputs,
                               con el objetivo de aplicar diversidad de las herramientas que SHINY nos brinda.")
                            
                          )
                          
                        )
                      )
                      
                      )
             
  )
)
             

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#      SERVER   #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

server <- function(input, output, session){
  
######## MAPA INTERACTIVO ###################
  
  output$currentTime <- renderText({
  invalidateLater(1000, session)
  paste("The current time is", Sys.time())})
  
  variable <- reactive({geodata %>%
      filter(crime == input$crimen, year == input$periodo)})
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addProviderTiles(providers$OpenStreetMap) %>%
      setView(-99.19945,19.39336, zoom = 10) %>%
      addCircleMarkers(data = variable(), lng = ~ long, lat = ~ lat,
                       radius = 5,
                       clusterOptions = markerClusterOptions(),
                       popup = ~ date)
  })
  
  
  output$value <- renderPrint({ input$crimen })
  output$value2 <- renderPrint({ input$periodo })
  output$value3 <- renderPrint({ geodata %>%
      filter(crime == input$crimen, year == input$periodo) %>%
               summarise(count = n())})
  
  
  ############ TIME LINE ###############
  
  #variable2 <- reactive({cuadran2 %>%
   #   filter(year == input$periodo2)})
  
  variable_test <- reactive({cuadran2 %>%
    filter(municipio == input$municipio, crime == input$crimen2)})
  
  variable3 <- reactive({cuadran2 %>%
      filter(municipio == input$crimen2)})
  
 
  output$plot <- renderPlot({
    ggplot(variable_test(), aes(x = year, y = count, color = year)) + geom_point(size = 3) +
      theme(text = element_text(size = 14),
            legend.position = 'bottom')
  })
  

  output$value4 <- renderPrint({ input$municipio })
  #output$value5 <- renderPrint({ input$periodo2 })
  output$value6 <- renderPrint({ input$crimen2 })
  
############## ANALISIS POR DELITO #################  
  
  output$table <- DT::renderDataTable(DT::datatable({
    
    data <- cuadran3
    
    if (input$delito != "Todos") {
      data <- data[data$crime == input$delito,]
    }
    if (input$sector != "Todos") {
      data <- data[data$sector1 == input$sector,]
    }
    if (input$anodel != "Todos") {
      data <- data[data$year == input$anodel,]
    }
    data
  }))
  
  
  ##############     RESUMEN     ################# 
  
  terms <- reactive({cuadran2 %>%
      filter(municipio == input$munici) %>%
               select(crime,year)})
  
  
  
  output$plot4 <- renderPlot({ 
    ggplot(terms(), aes(x = year, fill = crime )) +
      geom_bar() +
      theme_pander() +
      scale_fill_pander()
  })

  
  
  }
  

  
  
 # Run the application 
shinyApp(ui = ui, server = server)

