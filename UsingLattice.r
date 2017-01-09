library(marmap);
library(lattice);
library(tourr)

data(nw.atlantic);
matl<-nw.atlantic;
atl<-as.bathy(matl);

wireframe(unclass(atl),shade=T,aspect=c(1/2,0.1),
          xlab="",ylab="",zlab="",scales=list(draw=FALSE,arrows=FALSE))





#animate_xy(flea[, 1:6])

#animate_dist(unclass(atl))

#animate_dist(matl[, 1:3], method = "hist")
#display_stereo(fl, tour_path = grand_tour(1))