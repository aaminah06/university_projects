library(ggplot2)
library(patchwork)
library(ggcorrplot)
library(MASS)
# READ THE DATA
abalone <- read.table('abalone.txt', header = T, stringsAsFactors = T)
str(abalone)
summary(abalone)

# remove rows where Height ==0
abalone <- abalone[abalone$Height != 0, ]
summary(abalone)


# examine  the plots~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
with(abalone,boxplot(Rings~Sex,
                     col = c("lightpink2", "honeydew3", "skyblue4"),
                     names = c("Female", "Infant", "Male"),
                     main= "Number of Rings (Age) by Sex",
                     ylab= "Number of Rings",
                     xlab = "Sex",
                     boxwex= 0.6, # make the box width thinner
                     las= 1))
continuous_vars <- abalone[, c("Length", "Diameter", "Height", "Wholewt", "Shuckedwt", "Viscerawt", "Shellwt")]
pairs(continuous_vars)
par(mfrow = c(3, 3))
plot(Rings~Length, col = "aquamarine4" , xlab ="Length", ylab = "Rings" ,data = abalone) # no outliers
plot(Rings~Diameter, col = "pink2", xlab ="Diameter", ylab = "Rings", data = abalone) # no outliers
plot(Rings~Height,col = "cadetblue3" , xlab = "Height", ylab = "Rings", data = abalone) #slice to values < 0.4

boxplot(abalone$Length, xlab ="Length", ylab = "Rings", col = "aquamarine4")
boxplot(abalone$Diameter, col = "pink2", xlab ="Diameter", ylab = "Rings")
boxplot(abalone$Height ,col = "cadetblue3" , xlab = "Height", ylab = "Rings")

hist(abalone$Length, xlab ="Length", ylab = "Rings", col = "aquamarine4" , main = "")
hist(abalone$Diameter, col = "pink2" ,xlab ="Diameter", ylab = "Rings" , main = "")
hist(abalone$Height ,col = "cadetblue3" , xlab = "Height", ylab = "Rings" , main = "")

par(mfrow = c(7, 3))
plot(Rings~Wholewt,col = "khaki" , xlab = "Weight (g)", ylab = "Rings", data = abalone)
plot(Rings~Shuckedwt,col = "ivory4" , xlab = "Weight of meat (g)", ylab = "Rings", data = abalone)
plot(Rings~Viscerawt, col = "plum1" , xlab = "Gut Weight (g)", ylab = "Rings", data = abalone)
plot(Rings~Shellwt,col = "palegreen3" , xlab = "Weight after being dried (g)", ylab = "Rings", data = abalone)

boxplot(abalone$Wholewt,col = "khaki" , xlab = "Weight (g)", ylab = "Rings")
boxplot(abalone$Shuckedwt, col = "ivory4" , xlab = "Weight of meat (g)", ylab = "Rings")
boxplot(abalone$Viscerawt, col = "plum1" , xlab = "Gut Weight (g)", ylab = "Rings")
boxplot(abalone$Shellwt, col = "palegreen3" , xlab = "Weight after being dried (g)") 

hist(abalone$Wholewt,col = "khaki" , xlab = "Weight (g)", ylab = "Rings",  main = "" )
hist(abalone$Shuckedwt, col = "ivory4" , xlab = "Weight of meat (g)", ylab = "Rings",  main = "" )
hist(abalone$Viscerawt, col = "plum1" , xlab = "Gut Weight (g)", ylab = "Rings",  main = "" )
hist(abalone$Shellwt, col = "palegreen3" , xlab = "Weight after being dried (g)",  main = "" )

# HEIGHT HAS OUTLIERS : SLICE VALUES / INCLUDE ONLY VALUES < 0.4
#LENGTH AND DIAMETER IS RIGHT SKEWED
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# fix data: 

# 1. remove outliers from height
par(mfrow = c(1, 3))
abalone <- abalone[abalone$Height <= 0.4, ]
plot(Rings~Height,col = "cadetblue3" , xlab = "Height", ylab = "Rings", data = abalone2) #slice to values < 0.4
boxplot(abalone2$Height ,col = "cadetblue3" , xlab = "Height", ylab = "Rings")
hist(abalone2$Height ,col = "cadetblue3" , xlab = "Height", ylab = "Rings", main = "")

# re-pot : looks normal
par(mfrow = c(3, 3))
plot(Rings~(Length), col = "aquamarine4" , xlab ="Length", ylab = "Rings" ,data = abalone) # no outliers
plot(Rings~(Diameter), col = "pink2", xlab ="Diameter", ylab = "Rings", data = abalone) # no outliers
plot(Rings~Height,col = "cadetblue3" , xlab = "Height", ylab = "Rings", data = abalone) #slice to values < 0.4

plot(Rings~ Wholewt, data = abalone)
plot(Rings~ sqrt(Wholewt), data= abalone)


# SIMPLE LINEAR MODEL:
lm11<-lm(Rings ~ Sex + Length +Diameter + Height + Wholewt + Shuckedwt + Viscerawt + Shellwt, data = abalone)  
summary(lm11)
lm1<-lm(Rings ~ Sex + Length +Diameter + Height + sqrt(Wholewt) + sqrt(Shuckedwt) + sqrt(Viscerawt) + sqrt(Shellwt), data = abalone)  
summary(lm1)

# model selection:
lm2 <- update(lm1, . ~ . - Sex)
summary(lm2)
# SEX has the highest p-value(0.241): hence remove it
lm3 <- update(lm2, . ~ . - Length)
summary(lm3)
lm44 <- lm( Rings ~ Diameter + Height + sqrt(Wholewt) + sqrt(Shuckedwt) + 
              sqrt(Viscerawt) + sqrt(Shellwt), data = abalone)

model1 <- lm(Rings ~ Diameter + Height + Wholewt + Shuckedwt + 
  Viscerawt + Shellwt, data = abalone)
summary(model1)
model2 <- lm(Rings ~ Length + Diameter + Height + sqrt(Wholewt) + 
               sqrt(Shuckedwt) + sqrt(Viscerawt) + sqrt(Shellwt), data = abalone)
summary(model2)

anova(model1, model2)
# ADD TRANSFORMATIONS : LOG TO RINGS
par(mfrow = c(2,4))
plot(log(Rings) ~ Sex + Length +Diameter + Height + Wholewt + Shuckedwt + Viscerawt + Shellwt, data = abalone)

model <- lm(log(Rings) ~ .^2, data = abalone)
summary(model)

#model selection:
lm1 <- update(model, . ~ . - Diameter:Height)
summary(lm1)
lm2 <- update(lm1, . ~ . - Sex:Viscerawt)
summary(lm2)
lm3 <- update(lm2, . ~ . - Sex:Height)
summary(lm3)
lm4 <- update(lm3, . ~ . - Sex )
summary(lm4)
lm5 <- update(lm4, . ~ . - Length:Wholewt )
summary(lm5)
lm6 <- update(lm5, . ~ . - Diameter:Shuckedwt)
summary(lm6)
lm7 <- update(lm6, . ~ . - Length:Sex)
summary(lm7)
lm8 <- update(lm7, . ~ . - Height:Viscerawt)
summary(lm8)
lm9 <- update(lm8, . ~ . - Wholewt)
summary(lm9)
lm10 <- update(lm9, . ~ . - Sex:Wholewt)
summary(lm10)
lm11 <- update(lm10, . ~ . - Shuckedwt:Sex)
summary(lm11)
lm12 <- update(lm11, . ~ . - Diameter:Shellwt)
summary(lm12)
lm13 <- update(lm12, . ~ . - Length:Viscerawt)
summary(lm13)
lm14 <- update(lm13, . ~ . - Length:Height)
summary(lm14)
lm15 <- update(lm14, . ~ . - Length:Shellwt)
summary(lm15)
lm16 <- update(lm15, . ~ . - Shellwt:Wholewt)
summary(lm16)
lm17 <- update(lm16, . ~ . - Viscerawt:Shellwt)
summary(lm17)
lm18 <- update(lm17, . ~ . - Diameter:Wholewt)
summary(lm18)
lm19 <- update(lm18, . ~ . - Diameter:Sex)
summary(lm19)
lm20 <- update(lm19, . ~ . - Shellwt:Sex) # all done for p-values > 0.05
summary(lm20)
lm21 <- update(lm20, . ~ . - Shuckedwt:Viscerawt)
summary(lm21)

# final model - lm 21
plot(lm21)

finalmodel <- lm( log(Rings) ~ Length + Diameter + Height + Shuckedwt + 
                   Viscerawt + Shellwt + Length:Diameter + Length:Shuckedwt + 
                   Diameter:Viscerawt + Height:Wholewt + Height:Shuckedwt + 
                   Height:Shellwt + Shuckedwt:Wholewt + Viscerawt:Wholewt + 
                   Shuckedwt:Shellwt, data = abalone)
# MODEL DIAGNOSTICS
par(mfrow = c(2,2))
qqnorm(finalmodel$residuals)
qqline(finalmodel$residuals)
hist(finalmodel$residuals, xlab = "Residuals")
box()
sres <- rstandard(finalmodel)
hist(sres, xlab = "Residuals")
box()
plot(sres ~ finalmodel$fitted.values, xlab = "Fitted values", ylab = "Standardised residuals")


