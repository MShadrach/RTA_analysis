*******************************************************
*******************************************************
// data cleaning

import excel "C:\Users\Administrator\Desktop\Shadrach Thesis\KATH data\RTA data 2021 - 2022.xlsx", firstrow clear

/*
SrNo Ward DischargeStatus OMFS Neurosurgery Generalsurgery BSPOP PlasticSurgery TTA GCS Disabilitymve BPsys BPdys RR SPO2 Pulse RBS Temp Occupation Roaduser Helmetedrestrained Vehicletype Specificvehicle Accidentdescription Causeofaccident Secondvehicle LOC BleedingfromENT Headache odq Skullfracture TBI Mandibular Facialfracture Headinjury Cspineinjury Chestinjury Arminjuryradiusulnahumerus Pelvicinjury Leginjuryfemurtibiafibula Polytrauma Polytraumawithheadinjury Abdomenalinjury Abrasion Multipleabrasion Laceration impression Timeseen Alcohol Smoking Referred Age Gender Locality EducationalStatus DateofAdmission DateofDischarge Speciality PrincipalDiagnosis AdditionalDiagnosis CostofTreatment NHISStatus ProvisionalDiagnosis MainDepartment Year Daysinadmission Monthofadmission Weathermonth Precipitationdays Cloudydays Sunnydays dayF nightF dayC nightC Festivemonth GCS_cat occupation educstatus gender tbi skullfracture cost3cat cost_h_l severity roaduser vehicletype agegroup agegrp accidentdescription outcomeofdischarge festivemonth isfestivemonth
*/

gen GCS_cat = 1 if GCS < 15
replace GCS_cat = 0 if GCS == 15 
label define GCS_cat 1 "<=14/15" 0 "15/15"
label values GCS_cat GCS_cat
tab GCS_cat

gen GCS_category = 1 if GCS < 15
replace GCS_category = 0 if GCS == 15 

tab Ward
codebook Ward
gen ward = 1 if Ward == "yellow"
replace ward = 2 if Ward == "orange"
replace ward = 3 if Ward == "red"
label define ward 1 "yellow" 2 "orange" 3 "red"
label values ward ward

codebook Specificvehicle
encode Specificvehicle, gen (specificvehicle)

replace Occupation = "Rider/Driver" if Occupation == "driver" | Occupation == "PRAGIA DRIVER" | Occupation == "Okada rider" | Occupation == "OKADA RIDER" | Occupation == "OKADA" | Occupation == "MOTOR RIDER" | Occupation == "Driver" | Occupation == "DRIVING" | Occupation == "DRIVER" | Occupation == "DISPATCH RIDER" | Occupation == "DELIVERY PERSONNEL" | Occupation == "Bus Driver" | Occupation == "Aboboyaa driver" | Occupation == "Aboboyaa Driver" | Occupation == "ABOBOYAA RIDER" | Occupation == "ABOBOYAA DRIVER" | Occupation == "ABOBOYA DRIVER"

replace Occupation = "Student" if Occupation == "STUDENT NURSE" | Occupation == "STUDENT"

replace Occupation = "Farmer/Trader" if Occupation == "AGRICULTURIST" | Occupation == "FARMER" | Occupation == "FARMING" | Occupation == "Farmer" | Occupation == "COCOA BUYER" | Occupation == "COCOA MARKETING" | Occupation == "COCOA PURCHASER" | Occupation == " PETTY TRADER" | Occupation == "Pub owner" | Occupation == "TRADER" | Occupation == "TRADING" | Occupation == "Trader" | Occupation == "bussiness" | Occupation == "trader" | Occupation == "Businessman" | Occupation == "BUSINESS MAN"

replace Occupation = "Civil servant" if Occupation == "Teacher" | Occupation == "TEACHING" | Occupation == "SOLDIER" | Occupation == "ROTATIONAL NURSE" | Occupation == "QUALITY CONTROL OFFICER" | Occupation == "Police Officer" | Occupation == "Pharmacist" | Occupation == "NADMO" | Occupation == "FIRE SERVICE"

replace Occupation = "Unemployed" if Occupation == "UNEMPOLYED" | Occupation == "UNKNOWN" | Occupation == "Unemployed" | Occupation == "none" | Occupation == "orther" | Occupation == "Other" | Occupation == "OTHER" | Occupation == "NONE" | Occupation == "NO WORK" | Occupation == "NA" | Occupation == "AGED" | Occupation == "CHILD" | Occupation == "Retired Headmaster"

replace Occupation = "Artisan" if (Occupation != "Unemployed" & Occupation != "Student" & Occupation != "Rider/Driver" & Occupation != "Civil servant" & Occupation != "Farmer/Trader")

tab Occupation Roaduser, chi
/*
encode Occupation, gen (occupation)
codebook Occupation
*/

hist Daysinadmission
gen Daysinadmission_cat = 1 if Daysinadmission < 6
replace Daysinadmission_cat = 2 if Daysinadmission >= 6

gen occupation = 0 if Occupation == "Unemployed"
replace occupation = 1 if Occupation == "Student"
replace occupation = 2 if Occupation == "Rider/Driver"
replace occupation = 3 if Occupation == "Civil servant"
replace occupation = 4 if Occupation == "Farmer/Trader"
replace occupation = 5 if Occupation == "Artisan"

label define occupation 0 "Unemployed" 1 "Student" 2 "Rider/Driver" 3 "Civil servant" 4 "Farmer/Trader" 5 "Artisan"
label values occupation occupation
codebook occupation


replace EducationalStatus = "Senior secondary" if EducationalStatus == "SECONDARY SCHOOL" | EducationalStatus == "SHS" | EducationalStatus == "SHS COMPLETED" | EducationalStatus == "SIX FORM" | EducationalStatus == "SSS" | EducationalStatus == "FORM FOUR"
replace EducationalStatus = "Primary" if EducationalStatus == "primary"
replace EducationalStatus = "Junior secondary" if EducationalStatus == "JSS" | EducationalStatus == "JHS"
replace EducationalStatus = "None" if EducationalStatus == "NA" | EducationalStatus == "NONE" | EducationalStatus == "OTHER" 
replace EducationalStatus = "Tertiary" if EducationalStatus == "tertiary"

tab EducationalStatus
gen educstatus = 0 if EducationalStatus == "None"
replace educstatus = 1 if EducationalStatus == "Primary"
replace educstatus = 2 if EducationalStatus == "Junior secondary"
replace educstatus = 3 if EducationalStatus == "Senior secondary"
replace educstatus = 4 if EducationalStatus == "Tertiary"
label define educstatus 0 "None" 1 "Primary" 2 "Junior secondary" 3 "Senior secondary" 4 "Tertiary"
label values educstatus educstatus
codebook educstatus

codebook Gender
gen gender = 1 if Gender == "Female"
replace gender = 2 if Gender == "Male"
label define gender 1 "Female" 2 "Male"
label values gender gender
codebook gender

codebook TBI
encode TBI, gen (tbi)
codebook Skullfracture
replace Skullfracture = "bosf" if Skullfracture == "bos"
replace Skullfracture = "scalp hematoma" if Skullfracture == "scalp hematomo"
encode Skullfracture, gen (skullfracture)
codebook skullfracture

label variable LOC "Loss of consciousness"

label define status 0 "No" 1 "Yes"
label values Referred status
label values LOC status
label values BleedingfromENT status
label values Headache status
label values Mandibular status
label values Facialfracture  status
label values Polytraumawithheadinjury status
label values Abdomenalinjury status
label values Abrasion status
label values Multipleabrasion status
label values Laceration status
label values Headinjury status
label values Chestinjury status
label values Cspineinjury status
label values Arminjuryradiusulnahumerus status
label values Pelvicinjury status
label values Leginjuryfemurtibiafibula status
label values NHISStatus status
label values Alcohol status
label values Smoking status
label values Helmetedrestrained status

codebook Alcohol
codebook Age CostofTreatment
tab Helmetedrestrained

gen cost3cat = 1 if CostofTreatment < 300
replace cost3cat = 2 if CostofTreatment >=300 & CostofTreatment <=600
replace cost3cat = 3 if CostofTreatment >=600
label define cost3cat 1 "< 300" 2 "300 - 600" 3 "> 600"
label values cost3cat cost3cat
label variable cost3cat "Cost of treatement categorized"

gen cost_h_l = 0 if CostofTreatment <= 400
replace cost_h_l = 1 if CostofTreatment > 400
label define cost_h_l 0 "<= 400" 1 "> 400"
label values cost_h_l cost_h_l
label variable cost_h_l "Cost of treatement categorized"

gen severity = 0 if Ward == "yellow"
replace severity = 1 if Ward == "orange"
replace severity = 1 if Ward == "red"
label define severity 0 "moderate" 1 "severe" 
label values severity severity

gen roaduser = 1 if Roaduser == "pedestrian"
replace roaduser = 2 if Roaduser == "rider"
replace roaduser = 3 if Roaduser == "pillion rider"
label define roaduser 1 "pedestrian" 2 "rider" 3 "pillion rider"
label values roaduser roaduser

gen vehicletype = 1 if Vehicletype == "motorcycle"
replace vehicletype = 2 if Vehicletype == "tricycle"
label define vehicletype 1 "motorcycle" 2 "tricycle"
label values vehicletype vehicletype

gen agegroup = 1 if Age < 18
replace agegroup = 2 if Age >=18 & Age <= 24
replace agegroup = 3 if Age >=25 & Age <= 34
replace agegroup = 4 if Age >=35 & Age <= 44
replace agegroup = 5 if Age >=45
label define agegroup 1 "< 18" 2 "18 - 24" 3 "25 - 34" 4 "35 - 44" 5 " > 45"
label values agegroup agegroup
label variable agegroup "Age group"

gen agegrp = 1 if Age < 35
replace agegrp = 2 if Age >= 35
label define agegrp 1 "< 35" 2 ">= 35"
label values agegrp agegrp
label variable agegrp "Age group"

codebook Accidentdescription
tab Accidentdescription

replace Accidentdescription = "Fell over/ down" if Accidentdescription == "fell-down" | Accidentdescription == "fell-off" | Accidentdescription == "fell-over" | Accidentdescription == "fell down" | Accidentdescription == "fell off" | Accidentdescription == "fell over" | Accidentdescription == "fell "

replace Accidentdescription = "Knocked off/ down" if Accidentdescription == "knocked-dow" | Accidentdescription == "knocked-down" | Accidentdescription == "knocked-off" | Accidentdescription == "knocked off" | Accidentdescription == "knocked down" | Accidentdescription == "kovked-down" | Accidentdescription == "kocked down"

replace Accidentdescription = "Toppled/rolled over" if Accidentdescription == "toppled-over" | Accidentdescription == "toppled over" | Accidentdescription == "rolled-over" | Accidentdescription == "rolled off"

replace Accidentdescription = "Thrown off" if Accidentdescription == "thrown-off" | Accidentdescription == "thrown off" | Accidentdescription == "lost control" | Accidentdescription == "sharp curve" | Accidentdescription == "skidded-off"

replace Accidentdescription = "Head on" if Accidentdescription == "head-on" | Accidentdescription == "crashed" | Accidentdescription == "collision with stone" | Accidentdescription == "collision" | | Accidentdescription == "collided" | Accidentdescription == "head on"

replace Accidentdescription = "T-boned" if Accidentdescription == "t-boned"

encode Accidentdescription, gen (accidentdescription)
codebook accidentdescription
/*
gen accidentdescription = 1 if Accidentdescription == "Fell over/ down"
replace accidentdescription = 2 if Accidentdescription == "Toppled/rolled over"
replace accidentdescription = 3 if Accidentdescription == "T-boned"
replace accidentdescription = 4 if Accidentdescription == "Thrown off"
replace accidentdescription = 5 if Accidentdescription == "Knocked off/ down"
replace accidentdescription = 6 if Accidentdescription == "Head on"

label define accidentdescription 1 "Fell over/ down" 2 "Toppled/rolled over" 3 "T-boned" 4 "Thrown off" 5 "Knocked off/ down" 6 "Head on"
label values accidentdescription accidentdescription
*/
tab DischargeStatus

gen outcomeofdischarge = 0 if OutcomeofDischarge == "Died"
replace outcomeofdischarge = 1 if OutcomeofDischarge == "Discharge" | OutcomeofDischarge == "DAMA"
label define outcomeofdischarge 0 "Died" 1 "Discharged"
label values outcomeofdischarge outcomeofdischarge

codebook outcomeofdischarge
codebook OutcomeofDischarge
drop OutcomeofDischarge

codebook Polytrauma

codebook Festivemonth
encode Festivemonth, gen(festivemonth)
codebook festivemonth
gen isfestivemonth = 1 if festivemonth >= 1
replace isfestivemonth = 0 if Festivemonth == ""
label define isfestivemonth 0 "No" 1 "Yes"
label values isfestivemonth isfestivemonth
codebook isfestivemonth

encode Secondvehicle, gen (secondvehicle)


encode Principaldiag, gen (principaldiagnosis)
tab principaldiagnosis

drop OMFS Neurosurgery Generalsurgery BSPOP PlasticSurgery TTA odq impression Speciality  PrincipalDiagnosis AdditionalDiagnosis ProvisionalDiagnosis MainDepartment Weathermonth Precipitationdays Cloudydays Sunnydays dayF nightF dayC nightC

save "C:\Users\Administrator\Desktop\Shadrach Thesis\KATH data\KATH_rta_data.dta", replace

export excel using "KATH_rta_data", firstrow(variables) replace


*******************
use KATH_rta_data, clear
codebook Headinjury
keep if Headinjury == 1

save "C:\Users\Administrator\Desktop\Shadrach Thesis\KATH data\KATH_Headinjury_rta_data.dta", replace

export excel using "KATH_Headinjury_rta_data", firstrow(variables) replace
*******************

******************************************************
******************************************************

// data analysis
use KATH_rta_data, clear

tab Causeofaccident

tab accidentdescription agegrp, chi
tab Principaldiag roaduser, chi
tab occupation	roaduser, chi
tab Monthofadmission specificvehicle, chi
tab GCS_cat roaduser, chi col
asdoc tab Timeseen

tab Monthofadmission vehicletype

tab roaduser specificvehicle
tab Year
codebook accidentdescription
tab Accidentdescription roaduser, chi


tab Ward
tab severity
tab agegroup roaduser, chi
tab educstatus roaduser, chi
tab accidentdescription Specificvehicle, chi
tab GCS outcomeofdischarge, chi
tab occupation roaduser, chi
tab Alcohol roaduser, chi
tab Smoking roaduser, chi


tab educstatus
tab occupation 
tab educstatus 
tab gender 
tab tbi 
tab skullfracture 
tab cost3cat 
tab cost_h_l 
tab roaduser 
tab vehicletype 
tab agegroup 
tab agegrp 
tab accidentdescription 
tab outcomeofdischarge 
tab festivemonth 
tab isfestivemonth
tab GCS
tab Locality
tab Specificvehicle
tab vehicletype
tab Alcohol
tab Smoking
tab roaduser
tab Helmetedrestrained
tab Referred
tab Timeseen
tab Speciality
tab outcomeofdischarge
tab DischargeStatus
tab LOC
tab BleedingfromENT 
tab Headache 
tab Headinjury 
tab Cspineinjury 
tab Chestinjury 
tab Arminjuryradiusulnahumerus 
tab Pelvicinjury 
tab Leginjuryfemurtibiafibula
tab NHISStatus
tab Ward

tab severity outcomeofdischarge, chi
tab severity DischargeStatus, chi
tab severity Headinjury, chi

tab Year

tab Ward LOC
tab gender roaduser
tab NHISStatus 
tab NHISStatus roaduser
tab vehicletype NHISStatus
tab roaduser NHISStatus, chi
tab agegrp roaduser, chi
tab agegroup roaduser, chi
tab Alcohol roaduser, chi
tab Smoking roaduser, chi
tab cost3cat NHISStatus, chi
tab cost_h_l NHISStatus, chi

tab vehicletype roaduser
tab outcomeofdischarge
tab accidentdescription
tab occupation

tab Gender roaduser, chi
tab EducationalStatus roaduser, chi
tab Referred roaduser, chi
codebook festivemonth
tab roaduser


tab Polytrauma
tab Polytrauma DischargeStatus, chi
tab Polytrauma severity, chi

tab Polytraumawithheadinjury
tab Abdomenalinjury 
tab Abrasion 
tab Multipleabrasion 
tab Laceration 
tab Skullfracture  Helmetedrestrained, chi
tab TBI  Helmetedrestrained, chi
tab Mandibular  Helmetedrestrained, chi
tab Facialfracture  
bysort vehicletype: tab Headinjury Helmetedrestrained, chi

tab GCS Polytrauma
tab GCS Headinjury, chi

tab Headinjury ward
tab Cspineinjury ward
tab Chestinjury ward
tab Arminjuryradiusulnahumerus ward
tab Pelvicinjury ward
tab Leginjuryfemurtibiafibula ward

tab bleedingfromENT severity
tab Headache severity
tab Headinjury severity
tab Cspineinjury severity
tab Chestinjury severity
tab Arminjuryradiusulnahumerus severity
tab Pelvicinjury severity
tab Leginjuryfemurtibiafibula severity

tab GCS
tab LOC 
tab BleedingfromENT 
tab Headache
tab Disabilitymve 
tab BPsys 
tab BPdys 
tab RR 
tab SPO2 
tab Pulse 
hist RBS, normal 
hist Temp, normal

tab Disabilitymve
codebook GCS EFAST BPsys BPdys RR SPO2 Pulse RBS Temp

tab Daysinadmission

tab severity ward
tab severity GCS
tab severity DischargeStatus, chi

tab agegroup

codebook accidentdescription

// set base levels 
// fvset base 4 educstatus
fvset base 2 agegrp
fvset base 3 severity
fvset base 3 accidentdescription

tab Daysinadmission LOC, chi

// checking for correlation
pwcorr Daysinadmission GCS LOC BleedingfromENT Headache BPdys RR SPO2 Pulse Temp Headinjury Cspineinjury Chestinjury Arminjuryradiusulnahumerus Pelvicinjury Leginjuryfemurtibiafibula agegroup severity roaduser occupation accidentdescription Helmetedrestrained vehicletype educstatus
// regressions start
//linear regression - daysinadmission
regress Daysinadmission GCS LOC BleedingfromENT Headache BPdys RR SPO2 Pulse Temp i.Headinjury i.Cspineinjury i.Chestinjury i.Arminjuryradiusulnahumerus i.Pelvicinjury i.Leginjuryfemurtibiafibula i.agegroup i.severity i.roaduser i.occupation i.accidentdescription i.Helmetedrestrained i.vehicletype i.educstatus

nbreg Daysinadmission GCS LOC BleedingfromENT Headache BPdys RR SPO2 Pulse Temp i.Headinjury i.Cspineinjury i.Chestinjury i.Arminjuryradiusulnahumerus i.Pelvicinjury i.Leginjuryfemurtibiafibula i.agegroup i.severity i.roaduser i.occupation i.accidentdescription i.Helmetedrestrained i.vehicletype i.educstatus, irr

gen logged_daysinadmission = log(Daysinadmission)
swilk logged_daysinadmission
hist logged_daysinadmission, normal

regress logged_daysinadmission GCS LOC BleedingfromENT Headache BPdys RR SPO2 Pulse Temp i.Headinjury i.Cspineinjury i.Chestinjury i.Arminjuryradiusulnahumerus i.Pelvicinjury i.Leginjuryfemurtibiafibula i.agegroup i.severity i.roaduser i.occupation i.accidentdescription i.Helmetedrestrained i.vehicletype i.educstatus

nbreg Daysinadmission i.severity
nbreg Daysinadmission i.Headinjury i.Cspineinjury i.Chestinjury i.Arminjuryradiusulnahumerus i.Pelvicinjury i.Leginjuryfemurtibiafibula
nbreg Daysinadmission Polytrauma,irr
nbreg Daysinadmission LOC bleedingfromENT Headache
nbreg Daysinadmission GCS, irr

glm Daysinadmission BPsys BPdys RR SPO2 Pulse Temp LOC bleedingfromENT Headache Headinjury Cspineinjury Chestinjury Arminjuryradiusulnahumerus Pelvicinjury Leginjuryfemurtibiafibula  ward roaduser  accidentdescription vehicletype occupation agegroup educstatus alcohol smoking, family(poisson) link(identity)

glm Daysinadmission BPsys BPdys RR SPO2 Pulse RBS Temp LOC bleedingfromENT Headache Headinjury Cspineinjury Chestinjury Arminjuryradiusulnahumerus Pelvicinjury Leginjuryfemurtibiafibula  ward roaduser  accidentdescription vehicletype occupation agegroup educstatus alcohol smoking, family(poisson) link(identity) eform

tab accidentdescription
tab Helmetedrestrained roaduser
tab roaduser Headinjury

pwcorr Helmetedrestrained Headinjury
// due to the nature of the dependent variable, family(poisson) link(log) is the best to model
glm Daysinadmission BPsys BPdys RR SPO2 Pulse RBS Temp LOC bleedingfromENT Headache Headinjury Cspineinjury Chestinjury Arminjuryradiusulnahumerus Pelvicinjury Leginjuryfemurtibiafibula  ward roaduser  accidentdescription vehicletype occupation agegroup educstatus Alcohol Smoking, family(poisson) link(log) eform

glm Daysinadmission BPsys BPdys RR SPO2 Pulse RBS Temp LOC bleedingfromENT Headache Headinjury Cspineinjury Chestinjury Arminjuryradiusulnahumerus Pelvicinjury Leginjuryfemurtibiafibula  i.ward i.roaduser i.vehicletype i.accidentdescription i.occupation i.agegroup i.educstatus Alcohol Smoking, family(poisson) link(log) eform

// test to see which analysis best to use
hist Daysinadmission, normal // it is positively skewed
swilk Daysinadmission // pvalue =0.0000, so variable is not normally distributed
summarize Daysinadmission, detail
// variance=3.117302 and mean = 3.181818, and a very close

// logistic regression - OutcomeofDischarge



/////////////
tab Daysinadmission Alcohol, chi
/////////////
tab accidentdescription Headinjury, chi 

// outcomeofdischarge logistic regression
logistic outcomeofdischarge Headinjury Pelvicinjury Chestinjury Cspineinjury Arminjuryradiusulnahumerus Leginjuryfemurtibiafibula

// Helmetedrestrained logistic regressions

logistic Helmetedrestrained Headinjury Pelvicinjury Chestinjury Cspineinjury Arminjuryradiusulnahumerus Leginjuryfemurtibiafibula

// among motorcycles
logistic Helmetedrestrained Headinjury Pelvicinjury Chestinjury Cspineinjury Arminjuryradiusulnahumerus Leginjuryfemurtibiafibula if vehicletypen == 1

// among tricycles
logistic Helmetedrestrained Headinjury Pelvicinjury Chestinjury Cspineinjury Arminjuryradiusulnahumerus Leginjuryfemurtibiafibula if vehicletypen == 2

// Headinjury association to Helmetedrestrained
logistic Helmetedrestrained Headinjury if vehicletypen == 2

// Headinjury association to Helmetedrestrained accounting for other confounding variables (motorcycle)
logistic Helmetedrestrained Headinjury alcohol Age gender educstatus occupation

logistic Helmetedrestrained Headinjury accidentdescription roaduser

//
regress Polytrauma gender
codebook Polytrauma

// Headinjury association to Helmetedrestrained accounting for other confounding variables (motorcycle)
logistic Helmetedrestrained Headinjury alcohol Age gender educstatus occupation isfestivemonth if vehicletypen == 1

logistic Helmetedrestrained Headinjury accidentdescription roaduser if vehicletypen == 1

// Headinjury association to Helmetedrestrained accounting for other confounding variables (tricycle)
logistic Helmetedrestrained Headinjury alcohol Age gender educstatus occupation if vehicletypen == 2

logistic Helmetedrestrained Headinjury accidentdescription roaduser if vehicletypen == 2

// Chestinjury association to Helmetedrestrained
logistic Helmetedrestrained Chestinjury if vehicletypen == 2

mlogit dischargereason LOC Headache bleedingfromENT
margins

mlogit dischargereason LOC bleedingfromENT Headache Helmetedrestrained, baseoutcome(1) rr



******************************************
tab vehicletypen festivemonth_n, exact
tab accidentdescription festivemonth_n, chi 
tab vehicletypen isfestivemonth, chi
tab vehicletypen Precipitation, chi
tab vehicletypen monthofadmission, chi
logistic Helmetedrestrained i.festivemonth_n
******************************************
// multiple imputation
clear
use KATH_rta_data
mi set mlong
mi register imputed RBS BPdys BPsys
// mi impute chained (10) : RBS BPdys BPsys
mi impute pmm (regress): RBS BPdys BPsys, add(10)
mi impute chained (regress) RBS BPdys BPsys, add(pmm, knn(10))
sum RBS
*****************************************

use KATH_rta_data
swilk BPdys
kwallis BPdys, by(Polytrauma)
kwallis BPsys, by(Polytrauma)

swilk Temp
kwallis SPO2, by(Headinjury)
kwallis BPsys, by(Headinjury)

swilk dischargereason
swilk outcomeofdischarge

tab dischargereason
tab outcomeofdischarge

nbreg outcomeofdischarge i.roaduser, irr
nbreg outcomeofdischarge Headinjury, irr
nbreg outcomeofdischarge Cspineinjury, irr
nbreg outcomeofdischarge Chestinjury, irr
nbreg outcomeofdischarge Arminjuryradiusulnahumerus, irr
nbreg outcomeofdischarge Leginjuryfemurtibiafibula, irr
nbreg outcomeofdischarge Pelvicinjury, irr
nbreg outcomeofdischarge Polytrauma, irr

nbreg dischargereason i.roaduser, irr

hist dischargereason
nbreg dischargereason LOC bleedingfromENT Headache Helmetedrestrained, irr

histogram Daysinadmission
nbreg Daysinadmission i.roaduser vehicletypen Polytrauma, irr

nbreg accidentdescription isfestivemonth , irr

mlogit accidentdescription i.festivemonth , rr

******************************************************
******************************************************
pwcorr severity  Headinjury Leginjuryfemurtibiafibula LOC agegrp roaduser educstatus gender NHISStatus Arminjuryradiusulnahumerus Daysinadmission cost_h_l Headache Polytraumawithheadinjury vehicletype

************************
**multinomial logistic**
************************
tab severity
mlogit severity agegrp, rr

tab GCS
mlogit GCS_cat agegrp, rr


***********************************
**univariate logistic** severity **
***********************************

logistic severity i.agegrp // sig (2)

logistic severity i.educstatus // sig (7)

logistic severity i.occupation //insig

logistic severity i.gender // sig (3)

logistic severity i.roaduser // sig (6)

logistic severity i.specificvehicle //insig

logistic severity i.Helmetedrestrained // insig

logistic severity i.accidentdescription // insig

logistic severity i.LOC //slighly sig (10)

logistic severity i.BleedingfromENT // insig

logistic severity i.Headache // insig

logistic severity i.Headinjury // sig (4)

logistic severity i.Arminjuryradiusulnahumerus //slighly sig (9)

logistic severity i.Leginjuryfemurtibiafibula // sig (1)

logistic severity i.Polytraumawithheadinjury // insig

logistic severity i.Polytrauma // insig

logistic severity i.Daysinadmission_cat // insig but 5 days is sig (8)

logistic severity i.isfestivemonth // insig

logistic severity i.cost_h_l  // sig (5)

****************************************************
*** LR test (Goodness of fit) ***

logistic severity i.Leginjuryfemurtibiafibula 
est store m1

logistic severity i.Leginjuryfemurtibiafibula i.agegrp 
est store m2
lrtest m1 m2 // sig

logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.gender
est store m3
lrtest m2 m3 // sig

logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.gender i.Headinjury 
est store m4
lrtest m3 m4 // insig

logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.gender i.cost_h_l
est store m4
lrtest m3 m4 // sig

logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.gender i.cost_h_l i.roaduser
est store m5
lrtest m4 m5 // sig

logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.gender i.cost_h_l i.roaduser i.educstatus
est store m6
lrtest m5 m6 // sig

logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.gender i i.cost_h_l i.roaduser i.educstatus i.Daysinadmission_cat
est store m7
lrtest m6 m7 // insig

logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.gender i.Headinjury i i.cost_h_l i.roaduser i.educstatus i.LOC
est store m7
lrtest m6 m7 // insig

logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.gender i.Headinjury i i.cost_h_l i.roaduser i.educstatus i.Arminjuryradiusulnahumerus
est store m7
lrtest m6 m7 // insig

***********************************************************
*****  backwards  ****

logistic severity i.roaduser i.agegrp i.educstatus i.gender i.LOC i.Headinjury i.Arminjuryradiusulnahumerus i.Leginjuryfemurtibiafibula i.cost_h_l i.Headache i.Polytraumawithheadinjury i.vehicletype
est store b1

logistic severity i.roaduser i.agegrp i.educstatus i.gender i.LOC i.Headinjury i.Leginjuryfemurtibiafibula i.cost_h_l i.Headache i.Polytraumawithheadinjury i.vehicletype
est store b2
lrtest b2 b1

logistic severity i.roaduser i.agegrp i.educstatus i.gender i.LOC i.Headinjury i.Leginjuryfemurtibiafibula i.cost_h_l i.Headache i.vehicletype
est store b3
lrtest b3 b2

logistic severity i.roaduser i.agegrp i.educstatus i.gender i.Headinjury i.Leginjuryfemurtibiafibula i.cost_h_l i.Headache i.vehicletype
est store b4
lrtest b4 b3

logistic severity i.roaduser i.agegrp i.educstatus i.gender i.Leginjuryfemurtibiafibula i.cost_h_l i.Headache i.vehicletype
est store b5
lrtest b5 b4

logistic severity i.roaduser i.agegrp i.educstatus i.gender i.Leginjuryfemurtibiafibula i.cost_h_l i.vehicletype
est store b6
lrtest b6 b5

fvset base 2 vehicletype
logistic severity i.agegrp i.educstatus i.gender i.Leginjuryfemurtibiafibula i.cost_h_l i.roaduser#i.vehicletype i.roaduser#i.agegrp i.vehicletype
est store b7
lrtest b7 b5


logistic severity i.Leginjuryfemurtibiafibula i.agegrp i.educstatus i.gender i.cost_h_l i.roaduser i.vehicletype
estat gof
***********************************************************
pwcorr PrincipalDiagnosis severity GCS_cat
logistic severity i.PrincipalDiagnosis
logistic severity i.roaduser
***********************************************************

************************
**multvariate logistic**
************************
fvset base 2 agegrp

logistic severity i.roaduser i.agegrp i.educstatus i.gender i.LOC i.Headinjury i.Arminjuryradiusulnahumerus i.Leginjuryfemurtibiafibula i.Daysinadmission_cat i.cost_h_l i.Headache i.Polytraumawithheadinjury i.vehicletype

estat gof

logistic severity i.roaduser i.agegrp i.educstatus i.gender i.LOC i.Headinjury i.Arminjuryradiusulnahumerus i.Leginjuryfemurtibiafibula i.Daysinadmission_cat i.cost_h_l i.Headache i.Polytraumawithheadinjury i.vehicletype

estat gof
***************

tab GCS_cat severity

logistic severity GCS_cat

*************************************************
logistic severity i.Leginjuryfemurtibiafibula
est store m1

logistic severity i.agegrp
est store m1

logistic severity i.agegrp i.educstatus
estimates store m2

lrtest m1 m2 //sig

logistic severity i.agegrp i.educstatus i.gender
estimates store m3

lrtest m2 m3//sig

logistic severity i.agegrp i.educstatus i.gender i.occupation
estimates store m4

lrtest m3 m4 //not sig

******************************

***********************************
**univariate logistic** GCS_cat **
***********************************
fvset base 3 roaduser

logistic GCS_cat i.agegrp // insig

logistic GCS_cat i.educstatus // insig

logistic GCS_cat i.occupation //insig

logistic GCS_cat i.gender // insig

logistic GCS_cat i.roaduser // sig (0.0249)

logistic GCS_cat i.specificvehicle //insig

logistic GCS_cat i.Helmetedrestrained // insig

logistic GCS_cat i.accidentdescription // slight sig (0.0603)

logistic GCS_cat i.LOC // sig (0.0045)

logistic GCS_cat i.BleedingfromENT // insig

logistic GCS_cat i.Headache // sig (0.0442)

logistic GCS_cat i.Headinjury // sig (0.0000)

logistic GCS_cat i.Arminjuryradiusulnahumerus //insig 

logistic GCS_cat i.Leginjuryfemurtibiafibula // sig (0.0042)

logistic GCS_cat i.Polytraumawithheadinjury // sig (0.0000)

logistic GCS_cat i.Polytrauma // sig (0.0017)

logistic GCS_cat i.Daysinadmission_cat // sig (0.0053)

logistic GCS_cat i.isfestivemonth // sig (0.0036)

logistic GCS_cat i.cost_h_l  // sig (0.0012)

*************************************************
***
logistic GCS_cat i.roaduser // sig (0.0249)

logistic GCS_cat i.accidentdescription // slight sig (0.0603)

logistic GCS_cat i.LOC // sig (0.0045)

logistic GCS_cat i.Headache // sig (0.0442)

logistic GCS_cat i.Headinjury // sig (0.0000)
est store a1

logistic GCS_cat i.Leginjuryfemurtibiafibula // sig (0.0042)

logistic GCS_cat i.Polytraumawithheadinjury // sig (0.0000)

logistic GCS_cat i.Polytrauma // sig (0.0017)

logistic GCS_cat i.Daysinadmission_cat // sig (0.0053)

logistic GCS_cat i.isfestivemonth // sig (0.0036)

logistic GCS_cat i.cost_h_l  // sig (0.0012)

**********************
logistic GCS_cat i.isfestivemonth

**********************
logistic GCS_cat i.Headinjury
est store a1

logistic GCS_cat i.Headinjury i.isfestivemonth
est store a2
lrtest a1 a2

logistic GCS_cat i.Headinjury i.isfestivemonth i.cost_h_l
est store a3
lrtest a2 a3

logistic GCS_cat i.Headinjury i.isfestivemonth i.cost_h_l i.Daysinadmission_cat
est store a4
lrtest a3 a4

logistic GCS_cat i.Headinjury i.isfestivemonth i.cost_h_l i.Daysinadmission_cat i.roaduser
est store a5
lrtest a4 a5

logistic GCS_cat i.Headinjury i.isfestivemonth i.cost_h_l i.Daysinadmission_cat i.roaduser i.gender
est store a6
lrtest a5 a6

logistic GCS_cat i.Headinjury i.isfestivemonth i.cost_h_l i.Daysinadmission_cat i.roaduser i.gender i.educstatus
est store a7
lrtest a6 a7

logistic GCS_cat i.Headinjury i.isfestivemonth i.cost_h_l i.Daysinadmission_cat i.roaduser i.gender i.educstatus i.LOC
est store a8
lrtest a7 a8

logistic GCS_cat i.Headinjury i.isfestivemonth i.cost_h_l i.Daysinadmission_cat i.roaduser i.gender i.educstatus i.LOC

estat gof
**********************
***
*************************************************
************************
**multvariate logistic**
************************
fvset base 2 agegrp

logistic GCS_cat i.Headinjury i.LOC i.roaduser i.isfestivemonth i.Leginjuryfemurtibiafibula i.Daysinadmission i.cost_h_l i.Headache i.Polytraumawithheadinjury i.Polytrauma
est store a1






******************************
use KATH_rta_data
tab GCS_cat severity, nol
use KATH_rta_data, clear
logistic GCS_cat severity
diagt GCS_cat severity
lsens, all replace
lroc
kappa GCS_cat severity 


logistic severity GCS_cat 
diagt severity GCS_cat 
kappa severity GCS_cat

*****************************
use KATH_rta_data
tab Year
tab Vehicletype Year
tab principaldiagnosis


ksmirnov Pulse

swilk Pulse

qnorm Pulse
qnorm Temp
qnorm BPdys

hist BPsys, normal
qnorm BPsys
ksmirnov BPsys
sktest Pulse