library(marmap);
library(lattice);
data(nw.atlantic);
atl<-nw.atlantic;
atl<-as.bathy(atl);
wireframe(unclass(atl),shade=T,aspect=c(1/2,0.1),
          xlab="",ylab="",zlab="",scales=list(draw=T,arrows=FALSE))