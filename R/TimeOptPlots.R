#change in crystal over time
library(ggforce)

data <- timecourseFiltered
plot <- ggplot(data, aes(x = as.numeric(Time), y = abschange*100)) +
  geom_line(aes(x =as.numeric(Time), y = meanAbsChange*100),  alpha = .8, size = 0.3, color = "black")+
  geom_errorbar(aes(ymin=meanAbsChange*100-sdabsChange*100, ymax=meanAbsChange*100+sdabsChange*100),
                color = "black", size = .3 ,width=.12) +
  geom_point(size = 3, alpha = 0.5, color = "#F8766D")+
  xlab("Time (min)")+
  ylab("Change in % Crystallinity")+
  theme_minimal(base_size = 15)+
  ggtitle("Water bath Incubation at 70 C")+
  scale_x_log10(breaks = unique(data$Time))+
  theme(axis.text.x = element_text(size = 10))+
  theme_minimal(base_size = 11)

png(filename=paste(path,"/timeVSCrystallinitychange.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1500)

#Plot
print(plot)

dev.off()

#############################

#crystal over time

data <- timecourseFiltered
x <- unique(data$Time)
plot <- ggplot(data, aes(x = (Time), y = post*100)) +
  geom_line(aes(x =(Time), y = meanPost*100),
            alpha = .8, size = 0.3, color = "black")+
  geom_errorbar(aes(ymin=meanPost*100-sdPost*100, ymax=meanPost*100+sdPost*100),
                color = "black", size = .3 ,width=.12) +
  geom_point(size = 3, alpha = 0.5, color = "#F8766D")+
  geom_sina(aes(x = ntime+.025, y = pre*100), size = 3, alpha = 0.5, color = "#F8766D", maxwidth = .3)+
  xlab("Time (min)")+
  ylab("% Crystallinity")+
  theme_minimal(base_size = 15)+
  ggtitle("Water bath Incubation at 70 C")+
  scale_x_log10(breaks = c(0.025,x), labels = as.character(c("NT",x)), minor_breaks= NULL)+
  theme(axis.text.x = element_text(size = 10))+
  theme_minimal(base_size = 11)


png(filename=paste(getwd(),"/timeVSCrystallinityw0.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1500)

#Plot
print(plot)

dev.off()

