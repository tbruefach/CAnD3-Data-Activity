# LOADING PACKAGES NEEDED FOR ANALYSIS
# renv::restore()
library(tidyverse)
library(haven)
library(skimr)
library(naniar)
library(Hmisc)
library(sjlabelled)
library(gt)
library(gtsummary)

# SELECTING MEASURES FROM 2017 GSS
gss <- read.csv('gss_2017.csv') %>% 
  select(c(SRH_110,                   # Self-Rated Health
           SRH_115,                   # Self-Rated Mental Health
           EHG3_01B,                  # Highest Educational Attainment
           AGEC,                      # Respondent's Age in Years
           SEX,                       # Respondent's Sex
           MARSTAT,                   # Marital Status
           FAMINCG2,                  # Family Income
           CHRINHDC,                  # Number of Children in Household
           VISMIN,                    # Visible Minority
           WGHT_PER))                 # Individual Survey Weight

# RENAMING VARIABLES TO BE LOWERCASE
colnames(gss) <- tolower(colnames(gss))


# SUMMARIZING VARIABLE VALUES AND DISTRIBUTIONS
gss %>% skim()


# CREATING MEASURES

  # Self-Rated Health (Ordinal)
      # Coded Excellent (1) - Poor (5)
gss <- gss %>% 
  mutate(srh = srh_110)

gss %>% count(srh, srh_110)


  # Self-Rated Mental Health (Ordinal)
      # Coded Excellent (1) - Poor (5)
gss <- gss %>% 
  mutate(srh_m = srh_115)

gss %>% count(srh_m, srh_115)


  # Educational Attainment (Ordinal)
      # Coded HS or Less (1) | Some College (2) | Bachelor's + (3)
gss <- gss %>% 
  mutate(edatt = ehg3_01b,
         edatt = case_when(edatt <= 2                ~ 1,    # HS or Less
                          (edatt >= 3 & edatt <= 5)  ~ 2,    # Some College
                          (edatt >= 6 & edatt <= 7)  ~ 3),   # Bachelor's +
         edatt = as_factor(edatt))

gss %>% count(edatt, ehg3_01b)


  # Age in Years (Continuous; capped at 80)
gss <- gss %>% mutate(age = agec)


  # Sex (Binary)
      # Coded Male (0) | Female (1)
gss <- gss %>% mutate(sex = sex-1)
gss %>% count(sex)


  # Marital Status (Changing from Nominal to Dichotomous)
      # Married/Common Law = Married (1) | All Else = Not Married (0)
gss <- gss %>% mutate(married = marstat,
                      married = case_when(marstat == 1 | marstat == 2 ~ 1,
                                          marstat >= 3 & marstat <= 6 ~ 0))

gss %>% count(married, marstat)


  # Family Income (Ordinal)
      # Values are: 1) Less than $25k; 2) $25k to $49.999k; 3) $50k to 74.999k;
      #             4) $75k to $99.999k; 5) $100k to $124.999k; 6) $125k or more
gss <- gss %>% mutate(faminc = as.numeric(famincg2))
gss %>% count(faminc)


  # Number of Children in Household (Discrete)
gss <- gss %>% mutate(kidsinhh =  as.numeric(chrinhdc))
gss %>% count(kidsinhh)


  # Visible Minority (Binary) 
      # Coded Yes (1) | No(0)
gss <- gss %>% mutate(racialmin = vismin)
gss <- gss %>% mutate(racialmin = case_when(racialmin == 1 ~ 1,
                                            racialmin == 2 ~ 0))

gss %>% count(racialmin, vismin)


# KEEPING ONLY THE VARIABLES TO BE USED IN ANALYSES

gss <- gss %>% select(c(srh,             
                        srh_m,           
                        edatt,           
                        age,             
                        sex,             
                        married,         
                        faminc,          
                        kidsinhh,        
                        racialmin,       
                        wght_per))       

# LABELLING VARIABLES AND VALUES

  # Variable Labels
label(gss$srh)       <- 'Self-Rated Health'
label(gss$srh_m)     <- 'Self-Rated Mental Health'
label(gss$edatt)     <- 'Educational Attainment'
label(gss$age)       <- 'Age'
label(gss$sex)       <- 'Female'
label(gss$married)   <- 'Marital Status'
label(gss$faminc)    <- 'Household Income'
label(gss$kidsinhh)  <- 'Number of Children in Household'
label(gss$racialmin) <- 'Racial Minority Status'
label(gss$wght_per)  <- 'Person-Weight'
                                         
                                         