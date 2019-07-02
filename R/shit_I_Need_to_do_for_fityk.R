
#   Here's the plan:
#   1. reuse code from master script to load all the fityk output files.
#   2. calculate the percent crystallinity, and put it into the masterScript.
#   3. We need to plot the fitted peaks, but this will require its own dataframe.
#   4. We need to get the raw ftir data and peaks in thier own frame.
#   5. peaks will be made from the fityk output file.
#   6. they will be reconstructed with Voigt() function, and all plotted together with GGplot
#   7. possibly think about doing the fitting in R....this could save a lot of time.
#   8. ...yeah probably in R.
















library("RcppFaddeeva")
##Voigt(x, x0, sigma, gamma, real = TRUE, ...)

x <- Voigt(1000:3000, 1726, 16.0084, 3.35124)
y <- Voigt(1000:3000, 1738, 9.5, 0)

z <- x + y
xy <- data.frame(1000:3000, x,y,z)

test <- ggplot(xy, aes(x = X1000.3000, y = x))+
  geom_line()+
  geom_line(aes(x = X1000.3000, y = y))+
  geom_line(aes(x = X1000.3000, y = z), size = 1)+
  xlim(c(1650,1800))
test


png(filename=paste(getwd(),"/gaussTest.png", sep = ""),
    type="cairo",
    units="in",
    width=6,
    height=5,
    pointsize=12,
    res=1000)

test
dev.off()
