## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup1, eval=FALSE-------------------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("lenkiefer/darklyplot")

## ----vignette,message=FALSE,warning=FALSE,out.width="50%",fig.width=12,fig.height=8----
library(darklyplot)
darklyplot(df=mtg_rate,column="rate",labelx="roundx",n.decimals=3)

## ----vignette-2,message=FALSE,warning=FALSE,out.width="50%",fig.width=12,fig.height=8----
darklyplot(df=mtg_rate,column="rate",
           labelx="roundx",n.decimals=3,
           minCol="white",maxCol="white",
           firstCol="white",lastCol="white")

## ----vignette-3,message=FALSE,warning=FALSE,out.width="50%",fig.width=12,fig.height=8----
darklyplot(df=mtg_rate,column="rate",labelx="roundx",n.decimals=3,
           refline=TRUE,refCol="yellow",refValue=5)

## ----vignette-4,message=FALSE,warning=FALSE,out.width="50%",fig.width=12,fig.height=8----
darklyplot(df=mtg_rate,column="rate",labelx="roundx",n.decimals=3,
           refCol="yellow",refline=TRUE,refValue=5,
           shade=TRUE,shadeCol="yellow",shadeAlpha=0.35)

## ---- eval=FALSE--------------------------------------------------------------
#  #> Error: Invalid input: date_trans works with objects of class Date only

## ----vignette-6,message=FALSE,warning=FALSE,out.width="50%",fig.width=12,fig.height=8----
txhousing2 <- txhousing[txhousing$city=="Lubbock",]
txhousing2$date <- as.Date(ISOdate(txhousing2$year, txhousing2$month,1))

darklyplot(df=txhousing2,column="sales",labelx="roundx",n.decimals=3)+
  labs(title="Monthly home sales in Lubbock, Texas")

## ----vignette-7,message=FALSE,warning=FALSE,out.width="50%",fig.width=12,fig.height=8----
# filter out months with missing sales data
txhousing2 <- txhousing2[!is.na(txhousing2$sales),]

darklyplot(df=txhousing2,column="sales",labelx="roundx",n.decimals=3)+
  labs(title="Monthly home sales in Lubbock, Texas")

## ----vignette-8,message=FALSE,warning=FALSE,out.width="50%",fig.width=12,fig.height=8----
# compute monthly percent changes for Austin Texas
txhousing3 <- txhousing[txhousing$city=="Austin",]
txhousing3$date <- as.Date(ISOdate(txhousing3$year, txhousing3$month,1))
txhousing3$dsales <- (txhousing3$sales/lag(txhousing3$sales,12) -1 )
txhousing3 <- txhousing3[!is.na(txhousing3$dsales),]

darklyplot(df=txhousing3,column="dsales",
           refline=TRUE,
           labelx="percent",
           #n.decimals corresponds to accuracy in scales::percent when labelx="percent"
           n.decimals=.1)+
  labs(title="12-month perent change home sales in Austin, Texas")

