library(rgl)
library(reshape)
calls = read.delim('twits.csv', header = T,sep = ",",stringsAsFactors = FALSE)


drops <- c("PersonalDescription","student","retired","football_team","language","location","username")
calls <- calls[ , !(names(calls) %in% drops)]



# our calls dataset has arbitrary lat/long pairs. So (as ever) we’ll need to do some manipulation of our data 
#before we can plot it.What we need to do is bucket our call counts into evenly spaced divisions, in order that we can create 
#a grid representing the geographical layout. 
#Fortunately, R has full support for this kind of binning, using the cut function:



bin_size = 0.1
calls$long_bin =  cut(calls$long, seq(min(calls$long), max(calls$long), bin_size))
calls$lat_bin =  cut(calls$lat, seq(min(calls$lat), max(calls$lat), bin_size))
calls$count = (calls$count) / 2 #need to do this to flatten out totals

#So now we’ve created a grid system, with each row in the dataset falling into a 0.18 x 0.18 degree grid square 
#(I chose 0.18 for the most important reason – its makes the visualization look better :-)). 
#Next we have to sum up all the call counts which are in the same lat/long bucket. 
#Thankfully we have the splendid reshape library to help us here:



calls = melt(calls[,5:7])
calls = cast(calls, lat_bin~long_bin, fun = sum, fill = 0)
calls = calls[,2:(ncol(calls)-1)]
calls = as.matrix(calls)


#We’ve now got our matrix, so we need to define the x, y, and z data for the rgl.surface 
#function (run help(rgl.surface) for more details), and then call it:
rgl.clear(type = c("shapes"))
# simple black and white plot
x =  (1: nrow(calls))
z =  (1: ncol(calls))
rgl.surface(x, z, calls)
rgl.bringtotop()


rgl.pop()
# nicer colored plot
ylim <- range(calls)
ylen <- ylim[2] - ylim[1] + 1
col <- topo.colors(ylen)[ calls-ylim[1]+1 ]


x =  (1: nrow(calls))
z =  (1: ncol(calls))

rgl.bg(sphere=TRUE,color=c("black","green"),  lit=FALSE)
#rgl.bg(sphere=TRUE, lit=TRUE, back="filled",fogtype="exp",texture=system.file("textures/sunsleep.png",package="rgl"))



rgl.viewpoint( theta = 300, phi = 30, fov = 170, zoom = 0.03)
rgl.surface(x, z, calls, color = col, shininess = 10)
rgl.bringtotop()



browseURL(paste("file://", writeWebGL(dir=file.path(tempdir(), "webGL"), width=800), sep=""))
