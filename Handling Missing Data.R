# CODING DATA VALUES AS MISSING
    # Note: Variables not included have no missing data

gss <- gss %>% replace_with_na(replace = list(srh =       c(7, 8, 9),
                                              srh_m =     c(7, 8, 9),
                                              edatt =     c(97, 98, 99),
                                              married =   c(97, 98),
                                              racialmin = c(7, 8, 9)))


# CREATING SAMPLE VARIABLE FOR ANALYSES (LISTWISE DELETION)

