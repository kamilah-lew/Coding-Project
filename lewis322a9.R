setwd("~/Documents/ School/SPRING 2B/ECON 322/R Studio")
sink("lewis322a9log.txt", append=FALSE, split=TRUE)
slid11 <- read.csv("slid11.csv", header=TRUE, sep=",")
base<-subset(slid11, wgsal42>0)
library("texreg")
C <- matrix(c(round(mean(base$wgsal42),2), round(mean(base$ecage26),2), round(mean(base$pvreg25),2),
              round(mean(base$yrschl18),2)), nrow=4)
colnames(C) <- c("mean/(sd)")
D <- matrix(c(round(mean(base$wgsal42),2), round(mean(base$ecage26),2), round(mean(base$pvreg25),2),
              round(mean(base$yrschl18),2)), nrow=4)
colnames(D) <- c("mean/(sd)")
rownames(C) <- c("wage", "age", "prov", "educ")
rownames(D) <- c("wage", "age", "prov", "educ")
tr <- list()
for (j in 1:ncol(C)) {
  tr[[j]] <- createTexreg(
    coef.names = rownames(C),
    coef = C[, j],
    se = D[, j]
  )
}
m1<-lm(wgsal42~ecage26 + pvreg25 + yrschl18, data=base)
library(stargazer)
stargazer(m1, type="html", out="table2.html", title="Table 2: OLS Regression Results" , notes.align
          = "l", notes.append = TRUE, notes="Observations with missing values dropped")
m2<-lm(wgsal42~ecage26 + immst15 + yrschl18, data=base)
stargazer(m2, type="html", out="table3.html", title="Table 3: OLS Regression Results" , notes.align
          = "l", notes.append = TRUE, notes="Observations with missing values dropped")
base$resid <- residuals(m1, data=base)
plot(base$resid, base$yrschl18)
r1<-lm(resid~ecage26 + pvreg25 + yrschl18, data=base)
stargazer(r1, type="html", out="table4.html", title="Table 4: Heteroskedasticity Regression" ,
          notes.align = "l", notes.append = TRUE, notes="Heteroskedasticity robust errors")
sink()