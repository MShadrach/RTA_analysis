library(tidyverse)
library(gtsummary)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(readxl)
library(eeptools)
library(readxl)
library(sjPlot)
library(irr)
library(performance)
library(see)

rta_data <- read_excel("C:/Users/Administrator/Desktop/Shadrach Thesis/KATH data/r analysis/KATH_rta_data.xls")
View(rta_data)
str(rta_data)
Daysinadmission_cat <- cut(rta_data$Daysinadmission, c(0,2,4,6,13), labels = c("1-2", "3-4", "5-6", ">7"))
Daysinadmission_cat


# rta_data <- transform(rta_data, 
#                      agegrp= factor(agegrp, ordered = TRUE),
#                      agegroup= factor(agegroup, ordered = TRUE),
#                      educstatus = factor(educstatus, ordered = TRUE),
#                      accidentdescription = factor(accidentdescription, labels = c("Fell over/down", "Toppled/Rolled over", "T-boned", "Thrown off", "Knocked off/down", "Head on")),
#                      outcomeofdischarge = factor(outcomeofdischarge, labels = c("Died", "Discharged")),
#                      GCS = as.numeric(GCS),
#                      ward = factor(wardn, labels = c("yellow", "orange", "red"), ordered = TRUE),
#                      gender = factor(gender, labels = c("Female", "Male")),
#                      dischargedsitituation = factor(dischargedsitituation),
#                      disabilitymve = factor(disabilitymve),
#                      occupation = factor(occupation, labels = c("Unemployed", "Student", "Rider/Driver", "Civil Servant", "Farmer/Trader", "Artisan")),
#                      DischargeStatus = factor(DischargeStatus, labels = c("Died", "DAMA", "DC")),
#                      severitybyward = factor(wardn, labels = c("Moderate", "Severe", "Critical")),
#                      Helmetedrestrained = factor(Helmetedrestrained, labels = c("No", "Yes")),
#                      festivemonth = factor(festivemonth_n, labels = c("Christmas", "Easter", "Eid-Adha", "Eid-Fitr")),
#                      Headache = factor(Headache, labels = c("No", "Yes")),
#                      bleedingfromENT = factor(bleedingfromENT, labels = c("No", "Yes")),
#                      LOC = factor(LOC, labels = c("No", "Yes")),
#                      Headinjury = factor(Headinjury, labels = c("No", "Yes")),
#                      Cspineinjury = factor(Cspineinjury, labels = c("No", "Yes")),
#                      Chestinjury = factor(Chestinjury, labels = c("No", "Yes")),
#                      Arminjuryulnahumerus = factor(Arminjuryulnahumerus, labels = c("No", "Yes")),
#                      Pelvicinjury = factor(Pelvicinjury, labels = c("No", "Yes")),
#                      Leginjuryfemurtibiafibula = factor(Leginjuryfemurtibiafibula, labels = c("No", "Yes")),
#                      vehicletype = factor(vehicletype),
#                      Roaduser = factor(Roaduser, labels = c("Pedestrian", "Rider", "Pillion rider")),
#                      isfestivemonth = factor(isfestivemonth),
#                      Timeseen = factor(Timeseen),
#                      specificvehicle = factor(specificvehicle),
#                      smoking = factor(smoking, labels = c("No", "Yes")),
#                      Alcohol = factor(alcohol, labels = c("No", "Yes")),
#                      NHISStatus = factor(NHISStatus, labels = c("No", "Yes")),
#                      Referred = factor(referred, labels = c("No", "Yes")),
#                      cost_h_l = factor(referred, labels = c("<=400", ">400")),
#                      cost3cat = factor(costcat, labels = c("<300", "300-600", ">600")),
#                      Daysinadmission_cat = factor(daysinadmission_cat),
#                      Monthofadmission = factor(Monthofadmission, labels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
# )

rta_data <- transform(rta_data, 
                      agegrp= factor(agegrp),
                      agegroup= factor(agegroup),
                      educstatus = factor(educstatus),
                      accidentdescription = factor(accidentdescription),
                      outcomeofdischarge = factor(outcomeofdischarge),
                      GCS = as.numeric(GCS),
                      GCS_cat = factor(GCS_cat),
                      GCS_category = factor(GCS_category, labels = c("15/15", "<14/15")),
                      Ward = factor(Ward),
                      ward = factor(ward),
                      gender = factor(gender),
                      Causeofaccident = factor(Causeofaccident),
                      Disabilitymve = factor(Disabilitymve),
                      occupation = factor(occupation),
                      DischargeStatus = factor(DischargeStatus),
                      severity = factor(severity, ordered = TRUE),
                      Helmetedrestrained = factor(Helmetedrestrained),
                      Festivemonth = factor(Festivemonth),
                      festivemonth = factor(festivemonth),
                      Headache = factor(Headache),
                      BleedingfromENT = factor(BleedingfromENT),
                      LOC = factor(LOC),
                      Principaldiag = factor(Principaldiag),
                      Fracture_open_closed = factor(Fracture_open_closed),
                      NHISStatus = factor(NHISStatus),
                      Year = factor(Year),
                      Headinjury = factor(Headinjury),
                      Cspineinjury = factor(Cspineinjury),
                      Chestinjury = factor(Chestinjury),
                      Arminjuryulnahumerus = factor(Arminjuryradiusulnahumerus),
                      Pelvicinjury = factor(Pelvicinjury),
                      Leginjuryfemurtibiafibula = factor(Leginjuryfemurtibiafibula),
                      Abdomenalinjury = factor(Abdomenalinjury),
                      Mandibular = factor(Mandibular),
                      Abrasion = factor(Abrasion),
                      Multipleabrasion = factor(Multipleabrasion),
                      Polytraumawithheadinjury = factor(Polytraumawithheadinjury),
                      Laceration = factor(Laceration),
                      vehicletype = factor(vehicletype),
                      Secondvehicle = factor(Secondvehicle),
                      Roaduser = factor(Roaduser),
                      roaduser = factor(roaduser),
                      isfestivemonth = factor(isfestivemonth),
                      Timeseen = factor(Timeseen),
                      specificvehicle = factor(specificvehicle),
                      Smoking = factor(Smoking),
                      Alcohol = factor(Alcohol),
                      Referred = factor(Referred),
                      cost_h_l = factor(cost_h_l),
                      cost3cat = factor(cost3cat),
                      Daysinadmission_cat = factor(Daysinadmission_cat),
                      skullfracture = factor(skullfracture),
                      tbi = factor(tbi),
                      Monthofadmission = factor(Monthofadmission, labels = 
                                                  c("Jan", "Feb", "Mar", "Apr", 
                                                    "May", "Jun", "Jul", "Aug", 
                                                    "Sep", "Oct", "Nov", "Dec"))
                      )
                      
str(rta_data)



table(rta_data$Daysinadmission_cat)

# agegroup <- cut(rta_data$Age, c(0,10,20,30,40,50,60,70,80,90), labels = c("0-10","11-20","21-30","31-40","41-50","51-60","61-70","71-80","81-90"))
# agegroup

###############################################################################
####################              Summaries           #########################
summary(rta_data$Age)
shapiro.test(rta_data$Age)

ggdensity(rta_data$Age, 
          main = "Density plot of Age",
          xlab = "Age")
hist(rta_data$Age)

###############################################################################




###############################################################################
###################            TABLES FOR DISTRIBUTIONS         ###############
###############################################################################

## Demographic Distribution by vehicle type
tab1 <- rta_data %>% select(c(agegrp, gender, educstatus, occupation, NHISStatus, Alcohol, Smoking, roaduser))  %>% 
  tbl_summary(by=roaduser,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              , digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab1

tab1.1 <- rta_data %>% select(c(agegrp, gender, educstatus, occupation, NHISStatus, Alcohol, Smoking, vehicletype))  %>% 
  tbl_summary(by=vehicletype,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              , digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab1.1

tab2 <- rta_data %>% select(c(Age, BPdys, BPsys, RR, Pulse, SPO2, Temp, RBS, roaduser))  %>% 
  tbl_summary(by=roaduser,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              , digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab2

tab2.1 <- rta_data %>% select(c(Age, BPdys, BPsys, RR, Pulse, SPO2, Temp, RBS, gender))  %>% 
  tbl_summary(by=gender,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              , digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab2.1

tab3 <- rta_data %>% select(c(Age, roaduser, vehicletype, accidentdescription, Secondvehicle, Helmetedrestrained, gender))  %>% 
  tbl_summary(by=gender,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              , digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab3

tab3.1 <- rta_data %>% select(c(Age, roaduser, vehicletype, accidentdescription, Secondvehicle, Helmetedrestrained, agegrp))  %>% 
  tbl_summary(by=agegrp,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              , digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab3.1

tab4 <- rta_data %>% select(c(Headache, BleedingfromENT, LOC, Helmetedrestrained))  %>% 
  tbl_summary(by=Helmetedrestrained,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab4

tab4.1 <- rta_data %>% select(c(Headache, BleedingfromENT, LOC, GCS_cat))  %>% 
  tbl_summary(by=GCS_cat,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab4.1

tab4.2 <- rta_data %>% select(c(Headache, BleedingfromENT, LOC, severity))  %>% 
  tbl_summary(by=severity,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab4.2

tab5 <- rta_data %>% select(c(Headinjury, Cspineinjury, Chestinjury, Arminjuryradiusulnahumerus, Pelvicinjury, Leginjuryfemurtibiafibula, Abdomenalinjury, Polytrauma, Polytraumawithheadinjury, Abrasion, Multipleabrasion, Laceration, severity))  %>% 
  tbl_summary(by=severity,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              , digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab5

tab5.1 <- rta_data %>% select(c(Headinjury, Cspineinjury, Chestinjury, Arminjuryradiusulnahumerus, Pelvicinjury, Leginjuryfemurtibiafibula, Abdomenalinjury, Polytrauma, Polytraumawithheadinjury, Abrasion, Multipleabrasion, Laceration, GCS_cat))  %>% 
  tbl_summary(by=GCS_cat,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              , digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab5.1

tab6 <- rta_data %>% select(c(skullfracture, tbi, Facialfracture, Mandibular, severity))  %>% 
  tbl_summary(by=severity,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab6

tab6.1 <- rta_data %>% select(c(skullfracture, tbi, Facialfracture, Mandibular, severity))  %>% 
  tbl_summary(by=severity,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab6.1

tab6.1 <- rta_data %>% select(c(skullfracture, tbi, Facialfracture, Mandibular, outcomeofdischarge))  %>% 
  tbl_summary(by=outcomeofdischarge,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab6.1

tab7 <- rta_data %>% select(c(severity, GCS, Daysinadmission, outcomeofdischarge, DischargeStatus, Principaldiag, Fracture_open_closed, CostofTreatment, ward))  %>% 
  tbl_summary(by=ward,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab7

tab7.1 <- rta_data %>% select(c(severity, GCS, Daysinadmission, outcomeofdischarge, DischargeStatus, Principaldiag, Fracture_open_closed, CostofTreatment, ward, roaduser))  %>% 
  tbl_summary(by=roaduser,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab7.1

tab8 <- rta_data %>% select(c(Monthofadmission, festivemonth, isfestivemonth, roaduser))  %>% 
  tbl_summary(by=roaduser,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab8

tab8.1 <- rta_data %>% select(c(Monthofadmission, festivemonth, isfestivemonth, specificvehicle))  %>% 
  tbl_summary(by=specificvehicle,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab8.1

tab8.2 <- rta_data %>% select(c(Monthofadmission, festivemonth, isfestivemonth, severity))  %>% 
  tbl_summary(by=severity,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab8.2

tab8.3 <- rta_data %>% select(c(Monthofadmission, festivemonth, isfestivemonth, vehicletype))  %>% 
  tbl_summary(by=vehicletype,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
              , missing = "no"
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab8.3

##############

tab7 <- rta_data %>% select(c(Polytrauma, Helmetedrestrained))  %>% 
  tbl_summary(by=Helmetedrestrained,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab7

tab8 <- rta_data %>% select(c(daysinadmission, dischargedsitituation))  %>% 
  tbl_summary(by=dischargedsitituation,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab8

#####################
tab9 <- rta_data %>% select(c(Daysinadmission_cat, DischargeStatus))  %>% 
  dplyr::filter(DischargeStatus  == "DAMA") %>%
  tbl_summary(by=DischargeStatus,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab9

tab10 <- rta_data %>% select(c(Daysinadmission, DischargeStatus))  %>% 
  dplyr::filter(DischargeStatus  == "DAMA") %>%
  tbl_summary(by=DischargeStatus,
              statistic = list(
              ), type = all_dichotomous() ~ "categorical"
              ,digits = all_continuous() ~ 2 
  ) %>% add_overall() %>% bold_labels()  %>% add_p()
tab10
#####################

## my_data$age_group <- relevel(my_data$age_group, ref = "young")



rta_data$educstatus <- relevel(rta_data$educstatus, ref = "None")
rta_data$vehicletype <- relevel(rta_data$vehicletype, ref = "motorcycle")
rta_data$agegrp <- relevel(rta_data$agegrp, ref = "< 35")
####################################
## univariate logistic regression ##
####################################

## severity of injury predictors

mod1 <- glm(severity ~ Leginjuryfemurtibiafibula, data = rta_data, family = binomial(link = "logit"))
model1 <- tbl_regression(mod1, exponentiate = TRUE) %>% bold_labels()

mod2 <- glm(severity ~ agegrp, data = rta_data, family = binomial(link = "logit"))
model2 <- tbl_regression(mod2, exponentiate = TRUE) %>% bold_labels()

mod3 <- glm(severity ~ gender, data = rta_data, family = binomial(link = "logit"))
model3 <- tbl_regression(mod3, exponentiate = TRUE) %>% bold_labels()

mod4 <- glm(severity ~ cost_h_l, data = rta_data, family = binomial(link = "logit"))
model4 <- tbl_regression(mod4, exponentiate = TRUE) %>% bold_labels()

mod5 <- glm(severity ~ roaduser, data = rta_data, family = binomial(link = "logit"))
model5 <- tbl_regression(mod5, exponentiate = TRUE) %>% bold_labels()

mod6 <- glm(severity ~ educstatus, data = rta_data, family = binomial(link = "logit"))
model6 <- tbl_regression(mod6, exponentiate = TRUE) %>% bold_labels()

## 
mod0 <- glm(severity ~ Leginjuryfemurtibiafibula + agegrp + gender + 
              cost_h_l + roaduser + educstatus, data = rta_data, family = binomial(link = "logit"))
model0 <- tbl_regression(mod0, exponentiate = TRUE) %>% bold_labels()


mod0 <- glm(severity ~ Leginjuryfemurtibiafibula + roaduser*agegrp + roaduser*vehicletype + gender + 
              cost_h_l + educstatus, data = rta_data, family = binomial(link = "logit"))
model0 <- tbl_regression(mod0, exponentiate = TRUE) %>% bold_labels() %>% add_significance_stars(thresholds = 0.05)
model0












#####################################



mod1 <- glm(severity ~ Headinjury, data = rta_data, family = binomial(link = "logit"))
model1 <- tbl_regression(mod1, exponentiate = TRUE) %>% bold_labels()
model1
##tab_model(model)

mod2 <- glm(severity ~ Headache, data = rta_data, family = binomial(link = "logit"))
model2 <- tbl_regression(mod2, exponentiate = TRUE) %>% bold_labels()

mod3 <- glm(severity ~ Leginjuryfemurtibiafibula, data = rta_data, family = binomial(link = "logit"))
model3 <- tbl_regression(mod3, exponentiate = TRUE) %>% bold_labels()

mod4 <- glm(severity ~ LOC, data = rta_data, family = binomial(link = "logit"))
model4 <- tbl_regression(mod4, exponentiate = TRUE) %>% bold_labels()

mod5 <- glm(severity ~ agegrp, data = rta_data, family = binomial(link = "logit"))
model5 <- tbl_regression(mod5, exponentiate = TRUE) %>% bold_labels()

mod6 <- glm(severity ~ roaduser, data = rta_data, family = binomial(link = "logit"))
model6 <- tbl_regression(mod6, exponentiate = TRUE) %>% bold_labels()
model6

mod7 <- glm(severity ~ educstatus, data = rta_data, family = binomial(link = "logit"))
model7 <- tbl_regression(mod7, exponentiate = TRUE) %>% bold_labels()

mod8 <- glm(severity ~ gender, data = rta_data, family = binomial(link = "logit"))
model8 <- tbl_regression(mod8, exponentiate = TRUE) %>% bold_labels()

mod9 <- glm(severity ~ NHISStatus, data = rta_data, family = binomial(link = "logit"))
model9 <- tbl_regression(mod9, exponentiate = TRUE) %>% bold_labels()

mod10 <- glm(severity ~ Arminjuryradiusulnahumerus, data = rta_data, family = binomial(link = "logit"))
model10 <- tbl_regression(mod10, exponentiate = TRUE) %>% bold_labels()

mod11 <- glm(severity ~ Daysinadmission, data = rta_data, family = binomial(link = "logit"))
model11 <- tbl_regression(mod11, exponentiate = TRUE) %>% bold_labels()

mod12 <- glm(severity ~ cost_h_l, data = rta_data, family = binomial(link = "logit"))
model12 <- tbl_regression(mod12, exponentiate = TRUE) %>% bold_labels()

mod13 <- glm(severity ~ Polytraumawithheadinjury, data = rta_data, family = binomial(link = "logit"))
model13 <- tbl_regression(mod13, exponentiate = TRUE) %>% bold_labels()

mod14 <- glm(severity ~ vehicletype, data = rta_data, family = binomial(link = "logit"))
model14 <- tbl_regression(mod14, exponentiate = TRUE) %>% bold_labels()

model14

######################################################




######################################################


######################################
## multivariate logistic regression ##
######################################

mod0 <- glm(severity ~ Headinjury + Leginjuryfemurtibiafibula + LOC + agegrp + 
               roaduser + educstatus + gender + NHISStatus + Arminjuryradiusulnahumerus + 
               Daysinadmission + cost_h_l + Headache + Polytraumawithheadinjury + 
               vehicletype, data = rta_data, family = binomial(link = "logit"))

model0 <- tbl_regression(mod0, exponentiate = TRUE) %>% bold_labels()
## tab_model(model)

table(rta_data$GCS_cat, rta_data$agegrp)
str(rta_data)
#####################################################

#####
rta_data$educstatus <- relevel(rta_data$educstatus, ref = "None")
rta_data$roaduser <- relevel(rta_data$roaduser, ref = "pillion rider")
#####


mod001 <- glm(GCS_category ~ Headinjury, data = rta_data, family = binomial(link = "logit"))
model001 <- tbl_regression(mod001, exponentiate = TRUE) %>% bold_labels()
model001

mod12 <- glm(GCS_category ~ isfestivemonth, data = rta_data, family = binomial(link = "logit"))
model12 <- tbl_regression(mod12, exponentiate = TRUE) %>% bold_labels()
model12

mod13 <- glm(GCS_category ~ cost_h_l, data = rta_data, family = binomial(link = "logit"))
model13 <- tbl_regression(mod13, exponentiate = TRUE) %>% bold_labels()
model13

mod14 <- glm(GCS_category ~ Daysinadmission_cat, data = rta_data, family = binomial(link = "logit"))
model14 <- tbl_regression(mod14, exponentiate = TRUE) %>% bold_labels()
model14

mod15 <- glm(GCS_category ~ roaduser, data = rta_data, family = binomial(link = "logit"))
model15 <- tbl_regression(mod15, exponentiate = TRUE) %>% bold_labels()
model15

mod16 <- glm(GCS_category ~ gender, data = rta_data, family = binomial(link = "logit"))
model16 <- tbl_regression(mod16, exponentiate = TRUE) %>% bold_labels()
model16

mod17 <- glm(GCS_category ~ educstatus, data = rta_data, family = binomial(link = "logit"))
model17 <- tbl_regression(mod17, exponentiate = TRUE) %>% bold_labels()
model17

mod00 <- glm(GCS_category ~ Headinjury + isfestivemonth + cost_h_l + Daysinadmission_cat + 
              roaduser + gender + educstatus, data = rta_data, family = binomial(link = "logit"))
model00 <- tbl_regression(mod00, exponentiate = TRUE) %>% bold_labels() %>% add_vif()
model00


mod000 <- glm(severity ~ Headinjury + Leginjuryfemurtibiafibula + LOC + agegrp +
                roaduser + educstatus + gender + Arminjuryradiusulnahumerus +
                Daysinadmission + cost_h_l + Headache + Polytraumawithheadinjury +
                vehicletype, data = rta_data, family = binomial(link = "logit"))

model000 <- tbl_regression(mod000, exponentiate = TRUE) %>% bold_labels()


tbl_regression(
  glm(severity ~ Polytraumawithheadinjury,
      data = rta_data, family = binomial(link = "logit")),
  exponentiate = TRUE) %>% bold_labels()


tbl_regression(
  glm(GCS_cat ~ vehicletype,
      data = rta_data, family = binomial(link = "logit")),
  exponentiate = TRUE) %>% bold_labels()

ratings_table <- table(rta_data$GCS_category, rta_data$severity)
kappa_result <- kappa2(ratings_table, "equal")
kappa_value <- kappa_result$value
kappa_value
kappa_result


# Count the occurrences of each accident cause
cause_counts <- table(rta_data$Causeofaccident)

# Create the bar chart
barplot(cause_counts, main = "Accident Causes", xlab = "Cause of Accident", ylab = "Number of Accidents", col = "skyblue", las = 2)

# Create the bar chart using ggplot2
ggplot(data = data.frame(cause = names(cause_counts), count = cause_counts),
       aes(x = factor(cause, levels = names(cause_counts)), y = count, fill = cause)) +
  geom_bar(stat = "identity") +
  labs(title = "Accident Causes",
       x = "Cause of Accident",
       y = "Number of Accidents") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

##############
# Sample data
str(rta_data)
# Count the occurrences of each accident cause
cause_counts <- table(rta_data$Causeofaccident)

# Create the bar chart using ggplot2
ggplot(data = data.frame(cause = names(cause_counts), count = as.numeric(cause_counts)),
       aes(x = factor(cause, levels = names(cause_counts)), y = count, fill = cause)) +
  geom_bar(stat = "identity") +
  labs(title = "Accident Causes",
       x = "Cause of Accident",
       y = "Number of Accidents") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 12))

