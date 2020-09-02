library(tidyverse)
library(readxl)
# options(dplyr.summarise.inform=F)
df <- read_xlsx("data-raw/200622_uhreg.xlsx")

# Select and rename relevant columns ----
df_col <- df %>%
  select(.meta_patient_id = new_ID,
         .meta_treatment_code = treatment_code,
         .meta_visit_type = visit_type,
         .meta_visit_day = visit_day,
         tschq_q1_age = age,
         tschq_q2_sex = sex,
         starts_with("audiological_examination"),
         starts_with("cgi"),
         starts_with("v_mdi"),
         starts_with("v_tfi"),
         starts_with("v_thi"),
         starts_with("v_tinnitus_questionnaire"),
         starts_with("tinnitus_severity"),
         starts_with("v_exp_tschq"),
         starts_with("v_whoqol_bref"),
         starts_with("v_tbf12"),
         starts_with("v_mini_tq")
  ) %>%
  rename_with(~ str_replace(.x, "last_validation_status$", "lvs")) %>%
  rename_with(~ str_replace(.x, "(audio)logical_examination", "\\1")) %>%
  rename_with(~ str_replace(.x, "v_(exp_)?(cgi|tfi|mdi|thi|whoqol|tbf12|tschq)(_bref)?", "\\2")) %>%
  rename_with(~ str_replace(.x, "v_tinnitus_questionnaire_gundh_(.*)", "tq_\\1")) %>%
  rename_with(~ str_replace(.x, "tinnitus_severity", "tsq")) %>%
  rename_with(~ str_replace(.x, "v_mini_tq", "minitq")) %>%
  rename_with(~ str_replace(.x, "((q)uestion|(score))_?", "\\2\\3")) %>%
  rename(tschq_q36_1_otologic_additional = tschq_q361_otologic_additional) %>%
  rename(tschq_q4_1_family_additional = tschq_q41_family_additional) %>%
  rename(tschq_q5_1_begin_tinnitus_additional = tschq_q51_begin_tinnitus_additional)


# Fix 0-padding in question numbering, so that the columns can be sorted alphabetically ----
colnames_new <-
  tibble(x = names(df_col)) %>%
  mutate(ss = str_split(x, "_", 2)) %>%
  mutate(questionnaire = map_chr(ss, 1)) %>%
  mutate(name_rest = map_chr(ss, 2)) %>%
  mutate(number = str_extract(name_rest, "[:digit:]+")) %>%
  group_by(questionnaire) %>%
  # mutate(number = if_else(str_detect(number, "[:alpha:]"), NA_character_, number)) %>%
  mutate(pad_width = suppressWarnings(max(nchar(number), na.rm = TRUE))) %>%
  mutate(pad_width = if_else(is.infinite(pad_width), 0, pad_width)) %>%
  mutate(number = str_pad(number,
                          width = pad_width,
                          pad = "0")) %>%
  ungroup() %>%
  mutate(x_new = paste0(questionnaire, "_", str_replace(name_rest, "[:digit:]+", number))) %>%
  select(x, x_new)

names(df_col) <- tibble(x = names(df_col)) %>%
  left_join(colnames_new, by = "x") %>%
  mutate(x_new = if_else(is.na(x_new), x, x_new)) %>%
  pull(x_new)

# Make questionnaire names uppercase, e.g., "TQ_q01" ----
colnames_new <- tibble(x = str_replace(names(df_col), "^(.+?)_(.*)", "\\1#\\2")) %>%
  separate(x, c("q", "rest"), sep = "#", fill = "right") %>%
  mutate(q = toupper(q))  %>%
  unite("x_new", q, rest, na.rm = TRUE) %>%
  pull(x_new)

names(df_col) <- colnames_new

df_alpha <- df_col[sort(names(df_col))]

# Convert variables to correct type where necessary and declare missing values ----
df_alpha %>%
  mutate(across(where(is.double), as.integer)) %>%
  mutate(TSCHQ_q02_sex = case_when(TSCHQ_q02_sex == "m" ~ 0L,
                                   TSCHQ_q02_sex == "f" ~ 1L,
                                   TRUE ~ NA_integer_)) %>%
  mutate(.META_patient_id = as.character(.META_patient_id)) %>%
  mutate(across(c(TSCHQ_q05_begin_tinnitus), ~ if_else(.x == "0000-00-00", NA_character_, .x))) %>%
  # some months and days are provided as "00" -> set as January or first of month, respectively
  mutate(across(c(TSCHQ_q05_begin_tinnitus), ~ str_replace_all(.x, "-00", "-01"))) %>%
  mutate(across(c(.META_visit_day, TSCHQ_q05_begin_tinnitus), lubridate::ymd)) %>%
  mutate(.META_visit_type = factor(.META_visit_type,
                                   levels = c("screening",
                                              "baseline",
                                              "interim_visit",
                                              "final_visit",
                                              "followup"),
                                   labels = c("S", "B", "I", "FV", "FU"))) %>%
  # TODO: AUDIO features
  mutate(across(c(CGI_q1,
                  matches("^(MDI|MINITQ|TBF12|TFI|THI|TQ|TSCHQ|TSQ|WHOQOL)_q.+") & where(is.integer)
  ), ~ if_else(.x == -1L, NA_integer_, .x))) -> df_fct

# Create missing subscales ----
df_fct %>%
  rowwise() %>%
  mutate(TFI_intrusive =
           if_else(sum(is.na(c(TFI_q01, TFI_q02, TFI_q03))) > 1,
                   NA_real_,
                   as.double(10 * mean(c(TFI_q01 / 10, TFI_q02, TFI_q03 / 10), na.rm = TRUE))),
         .before = "THI_lvs") %>%
  mutate(TFI_sense_of_control =
           if_else(sum(is.na(c(TFI_q04, TFI_q05, TFI_q06))) > 1,
                   NA_real_,
                   as.double(10 * mean(c(TFI_q04, TFI_q05, TFI_q06), na.rm = TRUE))),
         .before = "THI_lvs") %>%
  mutate(TFI_cognitive =
           if_else(sum(is.na(c(TFI_q07, TFI_q08, TFI_q09))) > 1,
                   NA_real_,
                   as.double(10 * mean(c(TFI_q07, TFI_q08, TFI_q09), na.rm = TRUE))),
         .before = "THI_lvs") %>%
  mutate(TFI_sleep =
           if_else(sum(is.na(c(TFI_q10, TFI_q11, TFI_q12))) > 1,
                   NA_real_,
                   as.double(10 * mean(c(TFI_q10, TFI_q11, TFI_q12), na.rm = TRUE))),
         .before = "THI_lvs") %>%
  mutate(TFI_auditory =
           if_else(sum(is.na(c(TFI_q13, TFI_q14, TFI_q15))) > 1,
                   NA_real_,
                   as.double(10 * mean(c(TFI_q13, TFI_q14, TFI_q15), na.rm = TRUE))),
         .before = "THI_lvs") %>%
  mutate(TFI_relaxation =
           if_else(sum(is.na(c(TFI_q16, TFI_q17, TFI_q18))) > 1,
                   NA_real_,
                   as.double(10 * mean(c(TFI_q16, TFI_q17, TFI_q18), na.rm = TRUE))),
         .before = "THI_lvs") %>%
  mutate(TFI_quality_of_life =
           if_else(sum(is.na(c(TFI_q19, TFI_q20, TFI_q21, TFI_q22))) > 1,
                   NA_real_,
                   as.double(10 * mean(c(TFI_q19, TFI_q20, TFI_q21, TFI_q22), na.rm = TRUE))),
         .before = "THI_lvs") %>%
  mutate(TFI_emotional =
           if_else(sum(is.na(c(TFI_q23, TFI_q24, TFI_q25))) > 1,
                   NA_real_,
                   as.double(10 * mean(c(TFI_q23, TFI_q24, TFI_q25), na.rm = TRUE))),
         .before = "THI_lvs"
  ) %>%
  mutate(TQ_emotional_distress = sum(
    TQ_q01, TQ_q05, TQ_q08, TQ_q11, TQ_q16,
    TQ_q18, TQ_q19, TQ_q20, TQ_q28, TQ_q37,
    TQ_q39, TQ_q41, na.rm = TRUE), .before = TSCHQ_lvs) %>%
  mutate(TQ_cognitive_distress = sum(
    TQ_q03, TQ_q13, TQ_q17, TQ_q21, TQ_q27,
    TQ_q43, TQ_q44, TQ_q47, na.rm = TRUE), .before = TSCHQ_lvs) %>%
  mutate(TQ_intrusiveness = sum(
    TQ_q05, TQ_q07, TQ_q10, TQ_q15, TQ_q20,
    TQ_q34, TQ_q35, TQ_q48, na.rm = TRUE), .before = TSCHQ_lvs) %>%
  mutate(TQ_auditory_perceptual_difficulties = sum(
    TQ_q02, TQ_q09, TQ_q14, TQ_q26, TQ_q33,
    TQ_q38, TQ_q50, na.rm = TRUE), .before = TSCHQ_lvs) %>%
  mutate(TQ_sleep_disturbances = sum(
    TQ_q04, TQ_q12, TQ_q31, TQ_q36, na.rm = TRUE), .before = TSCHQ_lvs) %>%
  mutate(TQ_somatic_complaints = sum(
    TQ_q22, TQ_q25, TQ_q51, na.rm = TRUE), .before = TSCHQ_lvs) %>%
  ungroup() %>%
  # If the TQ total score is missing because of more than 8 missing values, all
  # subscales will also be set to “missing”.
  # mutate(across())
  mutate(across(c(TQ_emotional_distress,
                  TQ_cognitive_distress,
                  TQ_intrusiveness,
                  TQ_auditory_perceptual_difficulties,
                  TQ_sleep_disturbances,
                  TQ_somatic_complaints),
                ~ if_else(is.na(TQ_score), NA_integer_, .x))) -> df_new_features

df_MDI_depression <- df_new_features %>%
  rowid_to_column("id") %>%
  select(id, starts_with("MDI_q")) %>%
  rowwise() %>%
  mutate(MDI_q08 = ifelse(is.na(MDI_q08a) & is.na(MDI_q08b),
                          NA_integer_,
                          as.integer(max(MDI_q08a, MDI_q08b, na.rm = TRUE)))) %>%
  mutate(MDI_q10 = ifelse(is.na(MDI_q10a) & is.na(MDI_q10b),
                          NA_integer_,
                          as.integer(max(MDI_q10a, MDI_q10b, na.rm = TRUE)))) %>%
  ungroup() %>%
  select(id, num_range("MDI_q", 1:10, width = 2)) %>%
  pivot_longer(cols = c(-id)) %>%
  group_by(id) %>%
  mutate(at_least_3 = value >= 3) %>%
  mutate(at_least_4 = value >= 4) %>%
  summarize(MDI_depression = case_when(
    all(is.na(value)) ~ NA_integer_,
    sum(at_least_4[1:3], na.rm = TRUE) == 2 &
      sum(at_least_3[4:10], na.rm = TRUE) %in% c(2,3) ~ 2L,
    sum(at_least_4[1:3], na.rm = TRUE) > 2 &
      sum(at_least_3[4:10], na.rm = TRUE) == 4 ~ 3L,
    sum(at_least_4[1:3], na.rm = TRUE) == 3 &
      sum(at_least_3[4:10], na.rm = TRUE) >= 5 ~ 4L,
    TRUE ~ 1L
  )) %>%
  mutate(MDI_depression = factor(MDI_depression, labels = c(
    paste(c("no", "mild", "moderate", "severe"), "depression")
  )))

df_new_features <- df_new_features %>%
  mutate(MDI_depression = df_MDI_depression$MDI_depression, .after = MDI_score)

# df_fct %>%
#   arrange(.META_visit_day) %>%
#   group_by(.META_patient_id) %>%
#   summarize(visit_type_course = paste(.META_visit_type, collapse = "-")) %>%
#   pull(visit_type_course) %>%
#   table() %>% sort()

uhreg <- df_new_features

usethis::use_data(uhreg, overwrite = TRUE)
