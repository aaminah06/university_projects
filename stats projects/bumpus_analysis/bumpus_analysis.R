library(lmtest)
library(MASS)
# READ THE DATA
bumpus <- read.table('bumpus.txt', header = T, stringsAsFactors = T)
str(bumpus)
summary(bumpus)
bumpus <- within(bumpus, {
  Surv <- as.numeric(Survival)
  SexN <- 2 - as.numeric(Sex)
})
bumpus$Sex <- relevel(bumpus$Sex, ref = "f")
par(mfrow = c(1,1))
hist(bumpus$TotalLength)
hist(bumpus$AlarExtent)
hist(bumpus$Weight)
hist(bumpus$BeakHead)
hist(bumpus$Humerus)
hist(bumpus$Femur)
hist(bumpus$Tibiotarsus)
hist(bumpus$SkullWidth)
hist(bumpus$Sternum)
plot(bumpus$Surv) # more males
# 1. Examine general plots
#2. Examine simple models: Full model had Surv as response, continuos variable and Sex and interaction term of continuous term and Sex. 
#Compare them with and without interaction terms and choose the best mode. If without interaction term was the best model, 
# model was compared with and without SexN variable. Best model was chosen using lrtest.

# 3. final models for each continuos variable are following:
Sex.lm<- glm(Surv ~  SexN , data=bumpus, family=binomial)
summary(Sex.lm)

totallength <-  glm(Surv ~ TotalLength + SexN +TotalLength:SexN, data=bumpus, family=binomial)
summary(totallength)
  
AlarExtent.lm <-  glm(Surv ~ AlarExtent, data=bumpus, family=binomial)
summary(AlarExtent.lm) # better without SexN and interaction terms, although still not significant
  
Weight.lm <- glm(Surv ~ Weight + SexN, data=bumpus, family=binomial)
summary(Weight.lm)  

Beakhead.lm <- glm(Surv ~ BeakHead, data=bumpus, family=binomial)
summary(Beakhead.lm)

Humerus.lm <- glm(Surv ~ Humerus, data=bumpus, family=binomial)
summary(Humerus.lm)

Femur.lm <-  glm(Surv ~ Femur  , data=bumpus, family=binomial)
summary(Femur.lm)

Tibiotarsus.lm <-  glm(Surv ~ Tibiotarsus, data=bumpus, family=binomial)
summary(Tibiotarsus.lm)

SkullWidth.lm <-  glm(Surv ~ SkullWidth, data = bumpus, family = binomial)
summary(SkullWidth.lm)

Sternum.lm <- glm(Surv ~ Sternum, data=bumpus, family=binomial)
summary(Sternum.lm)

# 4. All explantory variales with no singificane at all (with and withot interaction term and SexN as additional explanatory), even by themselves, were removed
# Remainaing explanatory variables were included in the final model for model selection inclusing all possible interaction between them
model.lm <- glm(Surv~ TotalLength + Weight + Humerus + SexN +
                      TotalLength:Weight + TotalLength:Humerus + TotalLength:SexN +
                      Weight:Humerus + Weight:SexN +
                  Humerus:SexN, 
                data = bumpus, family = binomial
                  )
summary(model.lm)
# stepAIC to choose best model
stepAIC(model.lm)

model.lm2 <- glm(formula = Surv ~ TotalLength + Weight + Humerus + SexN + 
                   TotalLength:SexN, family = binomial, data = bumpus)
summary(model.lm2)


# MODEL SELECTION AFTER STEP AIC:
lm1 <- update(model.lm2, . ~ . - TotalLength:SexN )
summary(lm1)

final.model <- glm(formula = Surv ~ TotalLength + Weight + Humerus + SexN, family = binomial, 
                   data = bumpus)
summary(final.model)

lrtest(final.model,model.lm2) # final.model is better

#### FINAL MODEL"
final.model <- glm(formula = (Surv) ~ (TotalLength) + (Weight) + (Humerus) + SexN, family = binomial, 
                   data = bumpus)
summary(final.model)

#### MODEL ASSESSMENT:
# EXAMINE THE RESIDUALS PLOTS
bumpus$Pres <- residuals(final.model, "pearson")
bumpus$Fitted <- fitted(final.model)
plot(Pres ~ Fitted, data = bumpus, xlab = "fitted values", ylab = "Pearson residuals",main = "Model 2",
     col = "skyblue4")
abline(h = 0)
hist(bumpus$Pres, xlab = "Pearson residuals", col = "skyblue4", main = "")
box()

par(mfrow = c(2, 2))
plot(final.model)
# DEVIANCE OF GOODNESS OF FIT SMALLER MODEL
dev <- final.model$null.deviance - final.model$deviance
df <- final.model$df.null - final.model$df.residual
1 - pchisq(dev, df) # fitted model is better 

#  TEST:
# the Parson Residuals should have a mean of 0 and SD of 1
mean(bumpus$ Pres) # 0.0122
sd(bumpus$Pres) # 1.01

mean_residuals <- mean(bumpus$Pres)
sd_residuals <- sd(bumpus$Pres)

# Perform a t-test for the mean
# Null: Mean of Pearson's Residuals = 0
# Alternate: mean of Pearson's Residuals != 0
t.test(bumpus$Pres, mu = 0) # p-value > 0.05 do not reject the null and 
                            #hence conclude that mean is not significantly different from 0

# Perform a chi-squared test for the standard deviation
# Null: sd of Pearson's Residuals = 1
# Alternate: sd of Pearson's Residuals != 1
observed_sd <- sd(bumpus$Pres)
expected_sd <- 1
chi_squared_stat <- ((observed_sd - expected_sd) / expected_sd)^2
df <- 1
1 - pchisq(chi_squared_stat, df) #p-value >0.05, hence do not reject the null and
                                # conclude that sd is not significantly different from 1

