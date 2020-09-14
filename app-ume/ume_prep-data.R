library(tidyverse)
library(uhregmisc)

df_uhreg <- uhreg

# treatment type ----
treat_types <- data_dict %>%
  filter(item == ".META_treatment_code") %>%
  mutate(value = map(value, ~ tibble(key = names(.x), val = .x))) %>%
  unnest(value) %>%
  select(key, val) %>%
  mutate(val = paste(key, val))
df_uhreg$.META_treatment_code <- factor(df_uhreg$.META_treatment_code,
                                 levels = treat_types$key,
                                 labels = treat_types$val) %>%
  fct_infreq() %>%
  fct_lump_n(n = 10,
             other_level = "Other treatments")

# visit type ----
visit_types <- data_dict$value[[which(data_dict$item == ".META_visit_type")]]
df_uhreg$.META_visit_type <- factor(df_uhreg$.META_visit_type,
                                 labels = visit_types)

# gender ----
genders <- data_dict$value[[which(data_dict$item == "TSCHQ_q02_sex")]]
df_uhreg$TSCHQ_q02_sex <- factor(df_uhreg$TSCHQ_q02_sex,
                                    labels = genders)

df_shiny <- df_uhreg %>%
  select(.gender = TSCHQ_q02_sex,
         .age = TSCHQ_q01_age,
         .visit_type = .META_visit_type,
         .treat_code = .META_treatment_code,
         AUDIO = AUDIO_left_frequency_loss_01,
         MDI = MDI_q01,
         MINITQ = MINITQ_q01,
         TBF12 = TBF12_q01,
         TFI = TFI_q01,
         THI = THI_q01,
         TQ = TQ_q01,
         TSCHQ = TSCHQ_q01_age,
         TSQ = TSQ_q1,
         WHOQOL = WHOQOL_q01)

write_rds(df_shiny, "app-ume/data.rds")
