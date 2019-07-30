#day0 <- fitykLongTerm(0)
#day3 <- fitykLongTerm(3)
#day7 <- fitykLongTerm(7)

day0_pol0 <- fitykLongTerm(0)
day3_pol0 <- fitykLongTerm(3)
day7_pol0 <- fitykLongTerm(7)



longTerm <- data.frame(day0$Temp, day0$Crystallinity, day3$Crystallinity, day7$Crystallinity)
names(longTerm) <- c("Temp","c0","c3","c7")
longTerm22 <- longTerm[longTerm$Temp == 22,]
longTerm37 <- longTerm[longTerm$Temp == 37,]

longTerm22$c0Mean <- mean(longTerm22$c0)
longTerm22$c3Mean <- mean(longTerm22$c3)
longTerm22$c7Mean <- mean(longTerm22$c7)

longTerm22$c0dev <- sd(longTerm22$c0)
longTerm22$c3dev <- sd(longTerm22$c3)
longTerm22$c7dev <- sd(longTerm22$c7)

longTerm37$c0Mean <- mean(longTerm37$c0)
longTerm37$c3Mean <- mean(longTerm37$c3)
longTerm37$c7Mean <- mean(longTerm37$c7)

longTerm37$c0dev <- sd(longTerm37$c0)
longTerm37$c3dev <- sd(longTerm37$c3)
longTerm37$c7dev <- sd(longTerm37$c7)

longTerm <- rbind(longTerm22,longTerm37)
longTerm <- melt(longTerm)
x <- longTerm[1:24,]
y <- longTerm[25:48,]
z <- longTerm[49:72,]

longTerm <- cbind(x, y$value, z$value)
names(longTerm) <- c("Temp","Day","Crystallinity", "Mean", "sd")
longTerm$Day <- substr(longTerm$Day, 2, 2)
longTerm_nopol <- longTerm

plot <- ggplot(longTerm, aes(x = as.numeric(Day), y = Crystallinity, color = Temp))+
  geom_jitter(size = 2, alpha = .7, width = .15)+
  geom_line(aes(x =as.numeric(Day), y = MeanCryst))+
  geom_errorbar(aes(ymin=len-sd, ymax=len+sd), width=.2,
                position=position_dodge(.9))
  theme_minimal()
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

