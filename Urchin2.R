#Plotting Urchin Counts
#Plot using the reshaped file
#save "urchincount_reshaped.csv"
rm(list = ls(all = TRUE))
setwd("~/Desktop/Urchin Data")

urchin = read.csv("urchincount_reshape.csv")
summary(urchin)
View(urchin)
coordinates(urchin) = c("longitude","latitude")

pal = brewer.pal(5,"Reds")
q5 = classIntervals(urchin$mean_urchincount2015, n=5, style="quantile")
q5Colours = findColours(q5,pal)

#Plot just the data
plot(urchin, col = q5Colours, pch=19,cex=.3,axes=T, ylab = "Longitude", xlab="Latitude")
legend("topleft",fill=attr(q5Colours,"palette"),
       legend = names(attr(q5Colours,"table")),bty="n",cex=0.75)
title("Survey Site Urchin Count 2015 ")


setwd("~/Desktop/Urchin Data/cnty24s")
county <-readOGR("county.shp","county")
View(county)

proj=CRS(proj4string(urchin)); 
#proj4string(county)=CRS("+init=epsg:4326") #this was for the other way round
proj4string(county)=CRS("+init=esri:102285")
# The spTransform function provides transformation between datum(s) and projections
county.proj=spTransform(county, proj)
# We check that maine and urchin.proj are identical before merging them
identical(proj4string(county.proj),proj4string(urchin))

plot(county,axes=TRUE, border="black",ylab = "Latitude", xlab="Longitude")
points(urchin.proj, col=q5Colours, pch=19,cex=.3)
legend("topleft",fill=attr(q5Colours,"palette"),
       legend = names(attr(q5Colours,"table")),bty="n",cex=0.75)
title("Survey Site Urchin Count 2015 ")

#Maine coastline shapefile http://www.mapcruzin.com/free-united-states-shapefiles/free-maine-arcgis-maps-shapefiles.htm
#Use the regions in the Shape file

#Run the variogram with this data as well!

