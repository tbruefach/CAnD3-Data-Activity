# CODING DATA VALUES AS MISSING
    # Note: Variables not included have no missing data or were already coded 
    # in the cleaning stage
gss <- gss %>% replace_with_na(replace = list(srh =       c(7, 8, 9),
                                              srh_m =     c(7, 8, 9)))


# CREATING SAMPLE VARIABLE FOR ANALYSES
    # Will use this variable to filter out cases missing any data
gss <- gss %>% mutate(sampmiss = rowSums(is.na(.)))
gss %>% count(sampmiss)

# SAMPLE DATASET WHICH EXCLUDES MISSING DATA (LISTWISE DELETION)
sample <- gss %>% filter(sampmiss == 0)
