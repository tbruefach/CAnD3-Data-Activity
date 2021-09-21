# CREATING TABLE 1: DESCRIPTIVE STATISTICS

  # Creating and Storing Table: tbl_1
tbl_1 <- sample %>% 
  tbl_summary(include   = c(srh, 
                            srh_m, 
                            edatt, 
                            faminc, 
                            age, 
                            married, 
                            kidsinhh, 
                            racialmin),
              type = list(faminc   ~ 'continuous',
                          kidsinhh ~ 'continuous'),
              
              by        = sex,
              
              statistic = list(all_continuous()  ~ "{mean} ({sd})",
                               all_dichotomous() ~ "0.{p}",
                               all_categorical() ~ "0.{p}"),
              
              digits    = list(all_continuous()  ~ 2,
                               all_categorical() ~ 0)) %>% 
  
  modify_header(update = list(label  ~ '**Variables**',
                              stat_1 ~ '**Male ({n})**', 
                              stat_2 ~ '**Female({n})**')) %>% 
  
  modify_footnote(update = c(stat_1, stat_2) ~ 
                  'Mean and standard deviations provided for continuous 
                  variables. Proportions provided for categorical variables') %>% 
  
  modify_caption('**TABLE 1. DESCRIPTIVE STATISTICS (N = 19755)**') %>% 
  
  bold_labels()


  # Prints Table 1 as HTML
tbl_1 %>% as_gt()

