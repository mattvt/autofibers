timecourseFiltered <- timecourseFiltered2

mean <- aggregate(timecourseFiltered[, 3], list(timecourseFiltered$Time), mean)

sd <- aggregate(timecourseFiltered[, 3], list(timecourseFiltered$Time), sd)

stats <- data.frame(cbind(mean, sd$x))

names(stats) <- c("Time","meanPost","sdPost")
stats

timecourseFiltered <- merge(timecourseFiltered,stats)



premean <- aggregate(timecourseFiltered$pre, list(timecourseFiltered$Time), mean)
presd   <- aggregate(timecourseFiltered$pre, list(timecourseFiltered$Time), sd)
stats <- data.frame(cbind(premean, presd$x))
names(stats) <- c("Time","meanpre","sdPre")
stats
timecourseFiltered <- merge(timecourseFiltered,stats)

timecourseFiltered
###################################

tempOpt <- fitykCalcs

mean <- aggregate(tempOpt[, 4], list(tempOpt$Temp), mean)

sd <- aggregate(tempOpt[, 4], list(tempOpt$Temp), sd)

stats <- data.frame(cbind(mean, sd$x))
stats
names(stats) <- c("Temp","meanCryst","sdcryst")
stats

tempOpt <- merge(tempOpt,stats)
tempOpt


#############

data <- tempOpt
plot <- ggplot(data, aes(x = as.numeric(Temp), y = Crystallinity*100)) +
  geom_line(aes(x =as.numeric(Temp), y = meanCryst*100),  alpha = .8, size = 0.3, color = "black")+
  geom_errorbar(aes(ymin=meanCryst*100-sdcryst*100, ymax=meanCryst*100+sdcryst*100),
                color = "black", size = .4 ,width=1.2) +
  geom_point(size = 3, alpha = 0.5, color = "#F8766D")+
  xlab("Temp C")+
  scale_x_continuous(breaks = unique(tempOpt$Temp))+
  ylab("% Crystallinity")+
  theme_minimal(base_size = 15)+
  ggtitle("Water bath Incubation for 32 min.")+
 #scale_x_log10()+
  theme_minimal(base_size = 11)

png(filename=paste(getwd(),"/tempVSCrystallinity.png", sep = ""),
    type="cairo",
    units="in",
    width=5,
    height=4,
    pointsize=12,
    res=1500)

#Plot
print(plot)

dev.off()













