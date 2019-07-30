#long Term plots of


plot <- ggplot(longTerm, aes(x = as.numeric(Day), y = Crystallinity, color = Temp))+
  geom_line(aes(x =as.numeric(Day), y = Mean))+
  geom_errorbar(aes(ymin=Mean-sd, ymax=Mean+sd), width=.8,
                position=position_dodge(.5)) +
  geom_point(size = 3, alpha = .6, position = position_dodge(width = 0.50))+
  xlab("Time (in days)")+
  ylab("Crystallinity")+
  ggtitle("Crystallinity Vs Time")+
  scale_x_continuous(breaks = c(0, 3, 7))+
  scale_y_continuous(breaks = seq(.52, .64, .02))+
  theme_minimal(base_size = 15)
plot

png(filename=paste(getwd(),"/LT.png", sep = ""),
    type="cairo",
    units="in",
    width=7,
    height=5,
    pointsize=12,
    res=250)

plot
dev.off()


