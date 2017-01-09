library(rgl)
library(sm)
rgl.open()


n<-100;
ngrid<-100
x<-rnorm(n);
z<-rnorm(n)



smobj<-sm.density(cbind(x,z),display="none",ngrid=ngrid)
sm.y<-smobj$estimate


xgrid<-seq(min(x),max(x),len=ngrid)
zgrid<-seq(min(z),max(z),len=ngrid)
bi.y<-dnorm(xgrid)%*%t(dnorm(zgrid))

yscale<-20
rgl.clear();
rgl.bg(color="#887777")
rgl.spheres(x,rep(0,n),z
            ,radius
            =0.1
            ,color=
              "#CCCCFF")
rgl.surface(xgrid,zgrid,sm.y*yscale,color="#FF2222",alpha=0.5)
rgl.surface(xgrid,zgrid,bi.y*yscale,color="#CCCCFF",front="lines")


for(i in 1:360) {
  rgl.viewpoint(i, i*(10/360), interactive=T) }


#rgl.close()




