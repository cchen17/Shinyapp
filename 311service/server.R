function(input,output){
  
  # show map with leaflet
  color <- colorFactor(topo.colors(7), service_data$Complaint.Type)
  output$mymap <- renderLeaflet({
    map_data<-service_data[service_data$Borough==input$selected,]
    map_data<-filter(map_data,Created.Date1==input$date)
    text<-paste("Agency:",service_data$Agency,
                              "<br>","Open Channel:",service_data$Open.Data.Channel.Type,
                              "<br>","Closed Date:",service_data$Closed.Date)
    leaflet(map_data) %>%
      setView(lng = -73.98928, lat = 40.75042, zoom = 11)%>%
      addProviderTiles("CartoDB.Positron",
                       options = providerTileOptions(noWrap = TRUE,
                                                     updateWhenZooming = FALSE,
                                                     updateWhenIdle = TRUE  ))%>%

      addCircleMarkers(
        lng = ~Longitude,
        lat= ~Latitude,
        color=~color(Complaint.Type),
        radius = 2,

        popup = paste("Agency:",map_data$Agency,
                      "<br>","Open Channel:",map_data$Open.Data.Channel.Type,
                      "<br>","Closed Date:",map_data$Closed.Date)
        #clusterOptions = markerClusterOptions()
      )%>%

      addLegend(
        "bottomleft",
        pal=color,
        values=~Complaint.Type,
        opacity =1,
        title="Type of Services"
      )
  })
  
  # show total number of complain grouped by Complaint.Type with histogram chart
  output$hist1 <- renderGvis({
    hist1_df<-service_data[service_data$Borough==input$selected,]%>%
      filter(Created.Date1==input$date)%>%
      group_by(Complaint.Type)%>%
      summarize(count=n())
    gvisColumnChart(hist1_df,xvar = "Complaint.Type",yvar = "count")
  })
  
  #show complain submitted channel with pie chart
  output$pie1 <- renderGvis({
    pie1_df<-service_data[service_data$Borough==input$selected,]%>%
      filter(Created.Date1==input$date)%>%
      group_by(Open.Data.Channel.Type)%>%
      summarize(count=n())
    gvisPieChart(pie1_df,labelvar = "Open.Data.Channel.Type",numvar = "count")
  })
  
  #show Agency info by pie chart
  output$pie2 <- renderGvis({
    pie2_df<-service_data[service_data$Borough==input$selected,]%>%
      filter(Created.Date1==input$date)%>%
      group_by(Agency)%>%
      summarize(count=n())
    gvisPieChart(pie2_df,labelvar = "Agency",numvar = "count")
  })
  
  # show data using DataTable
  output$table <- DT::renderDataTable({
    table_df<-service_data%>%
      filter(Borough==input$selected)%>%
      filter(Created.Date1>=input$daterange[1]&Created.Date1<=input$daterange[2])

    datatable(table_df[2:9], rownames=FALSE) 
  })
  
  # show trend of submitted complains with google line chart
  output$line1 <- renderGvis({
    line_df<-service_data[service_data$Borough==input$selected,]%>%
      filter(Created.Date1>=input$daterange[1]&Created.Date1<=input$daterange[2])%>%
      group_by(Date=Created.Date1,Complaint.Type)%>%
      summarize(count=n())
    line_df<-dcast(line_df,Date~Complaint.Type, value.var="count")
    gvisLineChart(line_df,xvar="Date",yvar=colnames(line_df[-1]),
                  options=list(legend="bottom"))
  })
  
}