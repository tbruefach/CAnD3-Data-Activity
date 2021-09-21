library(gt)
library(gtsummary)
install.packages('gtsummary')

gtsummary::


gss %>% filter(sampmiss == 0) %>% skim()

gss %>% filter(sampmiss == 0) %>%  
  tbl_summary(include   = c(srh, 
                            srh_m, 
                            edatt, 
                            faminc, 
                            age, 
                            married, 
                            kidsinhh, 
                            racialmin),
              
              by        = sex,
              
              statistic = list(age               ~ "{mean} ({sd})",
                               all_dichotomous() ~ "0.{p}",
                               all_categorical() ~ "0.{p}"),
              
              digits    = list(all_continuous()  ~ 2,
                               all_categorical() ~ 0)) %>% 
  
  modify_header(update = list(stat_1 ~ 'Male ({n})', stat_2 ~ 'Female({n})')) %>% 
  
  modify_footnote(update = list(stat_1 ~ NA, stat_2 ~ NA)) %>% 
  
  modify_caption('**TABLE 2. DESCRIPTIVE STATISTICS**') %>% 
  
  bold_labels()

