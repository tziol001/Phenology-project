install.packages("spocc")
library(googleVis)

AndrewMap <- gvisMap(Andrew, "LatLong" , "Tip", 
                     options=list(showTip=TRUE, 
                                  showLine=TRUE, 
                                  enableScrollWheel=TRUE,
                                  mapType='terrain', 
                                  useMapTypeControl=TRUE))
plot(AndrewMap)


greenup_diff1<-rasterToPoints(greenup_diff)
greenup_diff1<-as.data.frame(greenup_diff1)


greenup_diff1$LatLong<-NA
greenup_diff1$LatLong<- paste0(greenup_diff1$y,":",greenup_diff1$x)


m <- gvisMap(greenup_diff1, "LatLong" , "layer",
                  options=list(
                                showTip=TRUE, 
                                showLine=TRUE, 
                                enableScrollWheel=TRUE,
                                mapType='terrain',
                                useMapTypeControl=TRUE,
                                icons=paste0("{",
                                             "'default': {'normal': 'http://icons.iconarchive.com/",
                                             "icons/icons-land/vista-map-markers/48/",
                                             "Map-Marker-Ball-Azure-icon.png',\n",
                                             "'selected': 'http://icons.iconarchive.com/",
                                             "icons/icons-land/vista-map-markers/48/",
                                             "Map-Marker-Ball-Right-Azure-icon.png'",
                                             "}}")))
                                
plot(m)
  return(invisible(m))
help(gvisMap)








***************************************************************