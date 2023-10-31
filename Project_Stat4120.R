install.packages("stringr")
install.packages("rvest")
install.packages("dplyr")
install.packages("plotly")
install.packages("readr")
install.packages("ggplot2")
install.packages("worldfootballR")
install.packages("writexl")

library(tidyverse)
library(rvest)
library(stringr)
library(dplyr)
library(ggplot2)
library(plotly)
library(readr)
library(worldfootballR)
library("writexl")  
#Main webpage:
page<-read_html("https://fbref.com/en/comps/22/Major-League-Soccer-Stats")

  #Create variable
      #Squad name, this will stay alphabetically and consistently
squad_names <- page %>% 
  html_nodes("#stats_squads_standard_for .left") %>%
  html_text()
    #Expected Goals
xG_stat<-page %>%html_nodes("#stats_squads_standard_for tbody .group_start:nth-child(17)")%>%
  html_text %>% as.numeric()
    #Actual Goals scored
Goals_Scored<-page %>%html_nodes("#stats_squads_shooting_for .right:nth-child(4)")%>%
  html_text %>% as.numeric()

    #Number of shot
Shot<-page %>%html_nodes("#stats_squads_shooting_for .right:nth-child(5)")%>%
  html_text %>% as.numeric()
    #Progressive Carries and Pass
PrgP<-page %>%html_nodes("#stats_squads_standard_for .right:nth-child(22)")%>%
  html_text %>% as.numeric()
PrgC<-page %>%html_nodes("#stats_squads_standard_for .right:nth-child(21)")%>%
  html_text %>% as.numeric()
  #Possession
Poss<-page %>%html_nodes("#stats_squads_possession_for td.center")%>%
  html_text %>% as.numeric()

  #Foul Drawn
FldDrw<-page %>%html_nodes("#stats_squads_misc_for .right:nth-child(8)")%>%
  html_text %>% as.numeric()
 
  #Age
Age<-page %>%html_nodes("#stats_squads_standard_for .right+ .center")%>%
  html_text %>% as.numeric()

  #Yel
Yel<-page %>%html_nodes("#stats_squads_standard_for .right:nth-child(15)")%>%
  html_text %>% as.numeric()

  #Red
Red<-page %>%html_nodes("#stats_squads_standard_for .right:nth-child(16)")%>%
  html_text %>% as.numeric()

#CS
CS<-page %>%html_nodes("#stats_squads_keeper_for .right:nth-child(15)")%>%
  html_text %>% as.numeric()

#GkLaunchAtt
GkLaunchAtt<-page %>%html_nodes("#stats_squads_keeper_adv_for .right:nth-child(14)")%>%
  html_text %>% as.numeric()

#GkPassAtt
GkPassAtt<-page %>%html_nodes("#stats_squads_keeper_adv_for .right:nth-child(16)")%>%
  html_text %>% as.numeric()

#SoT shot on target
SoT<-page %>%html_nodes("#stats_squads_shooting_for .right:nth-child(6)")%>%
  html_text %>% as.numeric()

#ShDist shot distance
ShDist<-page %>%html_nodes("#stats_squads_shooting_for .right:nth-child(12)")%>%
  html_text %>% as.numeric()

#PassDist pass distance
PassDist<-page %>%html_nodes("#stats_squads_passing_for .right:nth-child(7)")%>%
  html_text %>% as.numeric()

#Progressive pass distance
PrgDist<-page %>%html_nodes("#stats_squads_passing_for .right:nth-child(8)")%>%
  html_text %>% as.numeric()

#PPA pass into penalty area
PPA<-page %>%html_nodes("#stats_squads_passing_for .right:nth-child(24)")%>%
  html_text %>% as.numeric()

#CrsPA crosses into penalty area
CrsPA<-page %>%html_nodes("#stats_squads_passing_for .right:nth-child(25)")%>%
  html_text %>% as.numeric()

#SCA by def action
ScaDef<-page %>%html_nodes("#stats_squads_gca_for .right:nth-child(11)")%>%
  html_text %>% as.numeric()

#Tackles at 1/3 side of the attacking side
TckATT_3rd<-page %>%html_nodes("#stats_squads_defense_for .right:nth-child(8)")%>%
  html_text %>% as.numeric()

#Through Ball
ThrB<-page %>%html_nodes("#stats_squads_passing_types_for .right:nth-child(8)")%>%
  html_text %>% as.numeric()

#Switches balls
SwtBall<-page %>%html_nodes("#stats_squads_passing_types_for .right:nth-child(9)")%>%
  html_text %>% as.numeric()

#Crosses in general
Cross<-page %>%html_nodes("#stats_squads_passing_types_for .right:nth-child(10)")%>%
  html_text %>% as.numeric()

#Corner Kicks
CrK<-page %>%html_nodes("#stats_squads_passing_types_for .right:nth-child(12)")%>%
  html_text %>% as.numeric()

#Create a dataset with all the variable scraped. 
my_dataframe <- data.frame(Squad = squad_names, xG = xG_stat, Goals=Goals_Scored, Shot=Shot, PrgC=PrgC, PrgP=PrgP, Poss=Poss,
                           FldDrw=FldDrw, Age=Age,Yel=Yel, Red=Red,GkLaunchAtt=GkLaunchAtt,GkPassAtt=GkPassAtt,
                           SoT=SoT,ShDist=ShDist,PassDist=PassDist,PrgDist=PrgDist, PPA=PPA,
                           CrsPA=CrsPA,ScaDef=ScaDef,TckATT_3rd=TckATT_3rd, CS=CS,
                           ThrB=ThrB,SwtBall=SwtBall,Cross=Cross, CrK=CrK)

  #Different between actual goals and expected Goals, positive number means that the
#the team is overperforming, while negative value mean the team is underperforming
my_dataframe$Diff_Gls<-my_dataframe$Goals-my_dataframe$xG
print(my_dataframe)


#Export the dataframe as excel file.
write_xlsx(my_dataframe, "C:/Users/vnlan/StatDataSet\\MLS_2023(1).xlsx")