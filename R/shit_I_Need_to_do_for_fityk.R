
#   Here's the plan:
#   1. reuse code from master script to load all the fityk output files.
#   2. calculate the percent crystallinity, and put it into the masterScript.
#   3. We need to plot the fitted peaks, but this will require its own dataframe.
#   4. We need to get the raw ftir data and peaks in thier own frame.
#   5. peaks will be made from the fityk output file.
#   6. they will be reconstructed with Voigt() function, and all plotted together with GGplot
#   7. possibly think about doing the fitting in R....this could save a lot of time.
#   8. ...yeah probably in R.


OGdata

plot <- ggplot(OGdata, aes(x = as.numeric(Temp), y = Crystallinity)) +
  stat_smooth()+
  geom_point(alpha = .5)+
  xlab("Temperature")+
  theme_minimal(base_size = 15)+
  ggtitle("Temperature Vs Crystallinity")

path <- getwd()

png(filename=paste(path,"/tempVSCrystallinityOG.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1500)

#Plot
print(plot)

dev.off()







kinetics
plot <- ggplot(kinetics, aes(x = time, y = Crystallinity)) +
  geom_point()+
  scale_x_discrete(limits=c("0mi", "0!5","1mi","2mi","4mi","8mi","16m","32m"))
plot

tempOpt
plot <- ggplot(tempOpt, aes(x = as.numeric(Temp), y = Crystallinity)) +
  geom_point()
  #scale_x_discrete(limits=c("0mi", "0!5","1mi","2mi","4mi","8mi","16m","32m"))
plot








