library(rgl) # NEEDS sudo apt-get install r-cran-rgl

r3dDefaults$windowRect <- c(0,50, 700, 700)

setwd("/home/mamonu/scripts/RGL")

source("ni-smoothed.r")
heights = smoothed

#color=c("black","green")
#rgl.bg(sphere=TRUE, lit=TRUE, back="filled",fogtype="none",texture=system.file("textures/sunsleep.png",package="rgl"))

rgl.bg(sphere=TRUE, color=c("black","green"), lit=TRUE, back="lines",fogtype="none")
rgl.bbox(color=c("#333377","white"), emission="#333377", expand=1.03,
         specular="#3333FF", shininess=5, alpha=0.8 )
rgl.clear("lights")
rgl.light(theta=0,phi=60)

ncolors = 100
colorlut = terrain.colors(ncolors)
colorlut[1] = "blue"
xg = seq(xlim[1],xlim[2],length=n)
yg = seq(ylim[1],ylim[2],length=n)
ymax = max(heights)
ymin = min(heights)
col = colorlut[1 + (ncolors - 1) * (heights - ymin)/(ymax - ymin)]


rgl.surface(2*yg, 2*xg, 4*heights, color=col, smooth=TRUE, specular="#000002")


light3d( diffuse = "yellow", 
        specular = "orange", viewpoint.rel = TRUE) 

for(i in seq(0, 3 * 360, by = 1)) {
  rgl.viewpoint(theta = i*(10/360), phi = i*12/360,zoom = 0.28,interactive=T,fov = 30)
 
}



#browseURL(paste("file://", writeWebGL(dir=file.path(tempdir(), "webGL"), width=700), sep=""))
