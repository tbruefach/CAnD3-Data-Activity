# CREATING TABLE 2: OLS REGRESSIONS OF SRH AND SRMH

  # Linear Model of Self-Rated Health
    # y ~ x1 + x2 + x3 ... , data = )
ols_srh <- lm(srh ~ edatt * sex + 
                    age +
                    married +         
                    faminc +        
                    kidsinhh +        
                    racialmin, 
                data = sample,
                weights = wght_per)

  # Creating SRH Table based on Linear Model
model_srh <- 
tbl_regression(ols_srh) %>% 
  modify_header(update = list(label     ~ '**Variables**',
                              estimate  ~ '***b***',
                              std.error ~ '***se***',
                              p.value   ~ '**p-value**')) %>% 
  add_significance_stars()


  # Linear Model of Self-Rated Mental Health
    # y ~ x1 + x2 + x3 ... , data = )
ols_srmh <- lm(srh_m ~ edatt * sex + 
                       age +
                       married +         
                       faminc +        
                       kidsinhh +        
                       racialmin, 
                 data = sample,
                 weights = wght_per)

  # Creating SRMH Table based on Linear Model
model_srmh <- 
  tbl_regression(ols_srmh) %>% 
  modify_header(update = list(label     ~ '**Variables**',
                              estimate  ~ '***b***',
                              std.error ~ '***se***',
                              p.value   ~ '**p-value**')) %>% 
  add_significance_stars()


  # Merging SRH and SRMH Tables to Create and Store Table 2: tbl_2
tbl_2 <- 
tbl_merge(list(model_srh, model_srmh),
          tab_spanner = c('**Self-Rated Health**', 
                          '**Self-Rated Mental Health**')) %>% 
          modify_caption('**TABLE 2. SEX MODERATES THE HEALTH-BENEFITS OF 
                 POSTSECONDARY EDUCATIONAL ATTAINMENT, NET OF CONTROLS (N = 19755)**') %>% 
          modify_footnote(update = c('p.value_1', 'p.value_2') ~ 'Significant p-values in bold.')

    # Prints Table 2 in HTML
tbl_2 %>% as_gt()
 
  
