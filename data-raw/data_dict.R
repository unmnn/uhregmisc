## code to prepare `data_dict` dataset goes here

library(dplyr)
library(tidyr)

# dd_stem ----
dd_stem <- tribble(

  ~item, ~description,
  # .META ----
  ".META_patient_id",
  "Patient ID",
  #-#
  ".META_treatment_code",
  "Treatment code",
  #-#
  ".META_visit_day",
  "Day of visit",
  #-#
  ".META_visit_type",
  "Type of visit",
  #-#
  # AUDIO ----
  "AUDIO_duration",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_01",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_02",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_03",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_04",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_05",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_06",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_07",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_08",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_09",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_10",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_11",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_12",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_13",
  NA_character_,
  #-#
  "AUDIO_left_frequency_loss_14",
  NA_character_,
  #-#
  "AUDIO_left_hearing_loss",
  "Hearing loss",
  #-#
  "AUDIO_left_maximal_tinnitus_frequency",
  NA_character_,
  #-#
  "AUDIO_left_minimal_masking_level",
  NA_character_,
  #-#
  "AUDIO_left_minimal_tinnitus_frequency",
  NA_character_,
  #-#
  "AUDIO_left_tinntitus_type",
  NA_character_,
  #-#
  "AUDIO_lvs",
  NA_character_,
  #-#
  "AUDIO_residual_inhibition",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_01",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_02",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_03",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_04",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_05",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_06",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_07",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_08",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_09",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_10",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_11",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_12",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_13",
  NA_character_,
  #-#
  "AUDIO_right_frequency_loss_14",
  NA_character_,
  #-#
  "AUDIO_right_hearing_loss",
  NA_character_,
  #-#
  "AUDIO_right_maximal_tinnitus_frequency",
  NA_character_,
  #-#
  "AUDIO_right_minimal_masking_level",
  NA_character_,
  #-#
  "AUDIO_right_minimal_tinnitus_frequency",
  NA_character_,
  #-#
  "AUDIO_right_tinnitus_type",
  NA_character_,
  #-#
  "AUDIO_survey_participation_appropriateness",
  NA_character_,
  #-#
  "AUDIO_tinnitus_matching",
  "Location of tinnitus",
  #-#
  # CGI ----
  "CGI_lvs",
  NA_character_,
  #-#
  "CGI_q1",
  paste0("Please rate the total improvement of your tinnitus complaints ",
         "compared to before beginning of treatment."),
  #-#
  # MDI ----
  "MDI_lvs",
  NA_character_,
  #-#
  "MDI_q01",
  "How much of the time have you felt low in spirits or sad?",
  #-#
  "MDI_q02",
  "How much of the time have you lost interest in your daily activities?",
  #-#
  "MDI_q03",
  "How much of the time have you felt lacking in energy and strength?",
  #-#
  "MDI_q04",
  "How much of the time have you felt less self- confident?",
  #-#
  "MDI_q05",
  "How much of the time have you had a bad conscience or feelings of guilt?",
  #-#
  "MDI_q06",
  "How much of the time have you felt that life was not worth living?",
  #-#
  "MDI_q07",
  paste0("How much of the time have you had difficulty in concentrating, ",
         "e.g. when reading the newspaper of watching TV?"),
  #-#
  "MDI_q08a",
  "How much of the time have you felt very restless?",
  #-#
  "MDI_q08b",
  "How much of the time have you felt subdued or slowed down?",
  #-#
  "MDI_q09",
  "How much of the time have you had trouble sleeping at night?",
  #-#
  "MDI_q10a",
  "How much of the time have you suffered from reduced appetite?",
  #-#
  "MDI_q10b",
  "How much of the time have you suffered from increased appetite?",
  #-#
  "MDI_score",
  "Major (ICD-10) Depression Inventory (MDI) score",
  #-#
  # MINITQ ----
  "MINITQ_lvs",
  NA_character_,
  #-#
  "MINITQ_q01",
  "I am aware of the noises from the moment I get up to the moment I sleep.",
  #-#
  "MINITQ_q02",
  paste0("Because of the noises I worry that there is something seriously ",
         "wrong with my body."),
  #-#
  "MINITQ_q03",
  "If the noises continue my life will not be worth living.",
  #-#
  "MINITQ_q04",
  "I am more irritable with my family and friends because of the noises.",
  #-#
  "MINITQ_q05",
  "I worry that the noises might damage my physical health.",
  #-#
  "MINITQ_q06",
  "I find it harder to relax because of the noises.",
  #-#
  "MINITQ_q07",
  "My noises are often so bad that I cannot ignore them.",
  #-#
  "MINITQ_q08",
  "It takes me longer to get to sleep because of the noises.",
  #-#
  "MINITQ_q09",
  "I am more liable to feel low because of the noises.",
  #-#
  "MINITQ_q10",
  "I often think about whether the noises will ever go away.",
  #-#
  "MINITQ_q11",
  "I am a victim of my noises.",
  #-#
  "MINITQ_q12",
  "The noises have affected my concentration.",
  #-#
  "MINITQ_score",
  "Mini-TQ total sum score",
  #-#
  # TBF12 ----
  "TBF12_lvs",
  NA_character_,
  #-#
  "TBF12_q01",
  "Because of your tinnitus is it difficult for you to concentrate?",
  #-#
  "TBF12_q02",
  paste0("Is it difficult for you to understand what people are saying ",
         "because of the intensity of your tinnitus?"),
  #-#
  "TBF12_q03",
  "Do you get annoyed by your tinnitus?",
  #-#
  "TBF12_q04",
  "Do you feel that you cannot escape your tinnitus?",
  #-#
  "TBF12_q05",
  paste0("Does your tinnitus interfere with your social activities (such as ",
         "going out to dinner, to the movies?"),
  #-#
  "TBF12_q06",
  "Do you feel frustrated because of your tinnitus?",
  #-#
  "TBF12_q07",
  "Does your tinnitus interfere with your job or household responsibilities?",
  #-#
  "TBF12_q08",
  "Because of your tinnitus is it difficult for you to read?",
  #-#
  "TBF12_q09",
  paste0("Do you feel that your tinnitus has placed stress on your ",
         "relationship with members of your family and friends?"),
  #-#
  "TBF12_q10",
  paste0("Do you find it difficult to focur your attention on things other ",
         "than your tinnitus?"),
  #-#
  "TBF12_q11",
  "Does your tinnitus make you feel anxious?",
  #-#
  "TBF12_q12",
  "Do you feel that you can‘t cope with your tinnitus?",
  #-#
  "TBF12_score",
  "TBF12 total sum score",
  #-#
  # TFI ----
  "TFI_lvs",
  NA_character_,
  #-#
  "TFI_q01",
  paste0("Please rate the total improvement of your tinnitus complaints ",
         "compared to before beginning of treatment."),
  #-#
  "TFI_q02",
  "How STRONG or LOUD was your tinnitus?",
  #-#
  "TFI_q03",
  "What percentage of your time awake were you ANNOYED by your tinnitus?",
  #-#
  "TFI_q04",
  "Did you feel IN CONTROL in regard to your tinnitus?",
  #-#
  "TFI_q05",
  "How easy was it for you to COPE with your tinnitus?",
  #-#
  "TFI_q06",
  "How easy was it for you to IGNORE your tinnitus?",
  #-#
  "TFI_q07",
  paste0("Over the past week, how much did your tinnitus interfere with ",
         "your ability to CONCENTRATE?"),
  #-#
  "TFI_q08",
  paste0("Over the past week, how much did your tinnitus interfere with ",
         "your ability to THINK CLEARLY?"),
  #-#
  "TFI_q09",
  paste0("Over the past week, how much did your tinnitus interfere with ",
         "your ability to FOCUS ATTENTION on other things besides your tinnitus?"),
  #-#
  "TFI_q10",
  paste0("How often did your tinnitus make it difficult to FALL ASLEEP or",
         "STAY ASLEEP?"),
  #-#
  "TFI_q11",
  paste0("How often did your tinnitus cause you difficulty in getting AS ",
         "MUCH SLEEP as you needed?"),
  #-#
  "TFI_q12",
  paste0("How much of the time did your tinnitus keep you from SLEEPING as ",
         "DEEPLY or as PEACEFULLY as you would have liked?"),
  #-#
  "TFI_q13",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your ability to HEAR CLEARLY?"),
  #-#
  "TFI_q14",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your ability to UNDERSTAND PEOPLE who are talking?"),
  #-#
  "TFI_q15",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your ability to FOLLOW CONVERSATIONS in a group or at meetings?"),
  #-#
  "TFI_q16",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your QUIET RESTING ACTIVITIES?"),
  #-#
  "TFI_q17",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your ability to RELAX?"),
  #-#
  "TFI_q18",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your ability to enjoy \"PEACE AND QUIET\"?"),
  #-#
  "TFI_q19",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your enjoyment of SOCIAL ACTIVITIES?"),
  #-#
  "TFI_q20",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your ENJOYMENT OF LIFE?"),
  #-#
  "TFI_q21",
  paste0("Over the past week, how much has your tinnitus interfered with ",
         "your RELATIONSHIPS with family, friends and other people?"),
  #-#
  "TFI_q22",
  paste0("How often did your tinnitus cause you to have difficulty ",
         "performing your WORK OR OTHER TASKS, such as home maintenance, school ",
         "work, or caring for children or others?"),
  #-#
  "TFI_q23",
  "How ANXIOUS or WORRIED has your tinnitus made you feel?",
  #-#
  "TFI_q24",
  "How BOTHERED or UPSET have you been because of your tinnitus?",
  #-#
  "TFI_q25",
  "How DEPRESSED were you because of your tinnitus?",
  #-#
  "TFI_score",
  "TFI total sum score",
  #-#
  "TFI_intrusive",
  "TFI \"intrusive\" subscale (unpleasantness, intrusiveness, persistence)",
  #-#
  "TFI_sense_of_control",
  "TFI \"sense of control\" subscale (reduced sense of control)",
  #-#
  "TFI_cognitive",
  "TFI \"cognitive\" subscale (cognitife interference)",
  #-#
  "TFI_sleep",
  "TFI \"sleep\" subscale (sleep disturbance)",
  #-#
  "TFI_auditory",
  "TFI \"auditory\" subscale (auditory difficulties attributed to tinnitus)",
  #-#
  "TFI_relaxation",
  "TFI \"relaxation\" subscale (interference with relaxation)",
  #-#
  "TFI_quality_of_life",
  "TFI \"quality of life\" subscale (quality of life reduced)",
  #-#
  "TFI_emotional",
  "TFI \"emotional\" subscale (emotional distress)",
  #-#
  # THI ----
  "THI_lvs",
  NA_character_,
  #-#
  "THI_q01",
  "Because of your tinnitus, is it difficult for you to concentrate?",
  #-#
  "THI_q02",
  paste0("Does the loudness of your tinnitus make it difficult for you to ",
         "hear people?"),
  #-#
  "THI_q03",
  "Does your tinnitus make you angry?",
  #-#
  "THI_q04",
  "Does your tinnitus make you feel confused?",
  #-#
  "THI_q05",
  "Because of your tinnitus, do you feel desperate?",
  #-#
  "THI_q06",
  "Do you complain a great deal about your tinnitus?",
  #-#
  "THI_q07",
  "Because of your tinnitus, do you have trouble falling to sleep at night?",
  #-#
  "THI_q08",
  "Do you feel as though you cannot escape your tinnitus?",
  #-#
  "THI_q09",
  paste0("Does your tinnitus interfere with your ability to enjoy your ",
         "social activities (such as going out to dinner, to the movies)?"),
  #-#
  "THI_q10",
  "Because of your tinnitus, do you feel frustrated?",
  #-#
  "THI_q11",
  "Because of your tinnitus, do you feel that you have a terrible disease?",
  #-#
  "THI_q12",
  "Does your tinnitus make it difficult for you to enjoy life?",
  #-#
  "THI_q13",
  "Does your tinnitus interfere with your job or household responsibilities?",
  #-#
  "THI_q14",
  "Because of your tinnitus, do you find that you are often irritable?",
  #-#
  "THI_q15",
  "Because of your tinnitus, is it difficult for you to read?",
  #-#
  "THI_q16",
  "Does your tinnitus make you upset?",
  #-#
  "THI_q17",
  paste0("Do you feel that your tinnitus problem has placed stress on your ",
         "relationships with members of your family and friends?"),
  #-#
  "THI_q18",
  paste0("Do you find it difficult to focus your attention away from your ",
         "tinnitus and on other things?"),
  #-#
  "THI_q19",
  "Do you feel that you have no control over your tinnitus?",
  #-#
  "THI_q20",
  "Because of your tinnitus, do you often feel tired?",
  #-#
  "THI_q21",
  "Because of your tinnitus, do you feel depressed?",
  #-#
  "THI_q22",
  "Does your tinnitus make you feel anxious?",
  #-#
  "THI_q23",
  "Do you feel that you can no longer cope with your tinnitus?",
  #-#
  "THI_q24",
  "Does your tinnitus get worse when you are under stress?",
  #-#
  "THI_q25",
  "Does your tinnitus make you feel insecure?",
  #-#
  "THI_score",
  "THI total score",
  #-#
  # TQ ----
  "TQ_lvs",
  NA_character_,
  #-#
  "TQ_q01",
  "I can sometimes ignore the noises when they are there.",
  #-#
  "TQ_q02",
  "I am unable to enjoy listening to music because of the noises.",
  #-#
  "TQ_q03",
  "It's unfair that I have to suffer with my noises.",
  #-#
  "TQ_q04",
  "I wake up more in the night because of my noises.",
  #-#
  "TQ_q05",
  "I am aware of the noises from the moment I get up to the moment I sleep.",
  #-#
  "TQ_q06",
  "Your attitude to the noise makes no difference to how it affects you.",
  #-#
  "TQ_q07",
  "Most of the time the noises are fairly quiet.",
  #-#
  "TQ_q08",
  "I worry that the noises will give me a nervous breakdown.",
  #-#
  "TQ_q09",
  paste0("Because of the noises I have difficulty in telling where sounds ",
         "are coming from."),
  #-#
  "TQ_q10",
  "The way the noises sound is really unpleasant.",
  #-#
  "TQ_q11",
  "I feel I can never get away from the noises.",
  #-#
  "TQ_q12",
  "Because of the noises I wake up earlier in the morning.",
  #-#
  "TQ_q13",
  "I worry whether I will be able to put up with this problem for ever.",
  #-#
  "TQ_q14",
  paste0("Because of the noises it is more difficult to listen to several ",
         "people at once"),
  #-#
  "TQ_q15",
  "The noises are loud most of the time",
  #-#
  "TQ_q16",
  paste0("Because of the noises I worry that there is something seriously ",
         "wrong with my body"),
  #-#
  "TQ_q17",
  "If the noises continue my life will not be worth living.",
  #-#
  "TQ_q18",
  "I have lost some of my confidence because of the noises.",
  #-#
  "TQ_q19",
  "I wish someone understood what this problem is like.",
  #-#
  "TQ_q20",
  "The noises distract me whatever I am doing.",
  #-#
  "TQ_q21",
  "There is very little one can do to cope with the noises.",
  #-#
  "TQ_q22",
  "The noises sometimes give me a pain in the ear or head.",
  #-#
  "TQ_q23",
  "When I feel low and pessimistic the noise seems worse.",
  #-#
  "TQ_q24",
  "I am more irritable with my family and friends because of the noises.",
  #-#
  "TQ_q25",
  "Because of the noises I have tension in the muscles of my head and neck.",
  #-#
  "TQ_q26",
  "Because of the noises other people's voices sound distorted to me.",
  #-#
  "TQ_q27",
  "It will be dreadful if these noises never go away.",
  #-#
  "TQ_q28",
  "I worry that the noises might damage my physical health.",
  #-#
  "TQ_q29",
  "The noise seems to go right through my head.",
  #-#
  "TQ_q30",
  "Almost all of my problems are caused by these noises.",
  #-#
  "TQ_q31",
  "Sleep is my main problem.",
  #-#
  "TQ_q32",
  paste0("It's the way you think about the noise – NOT the noise itself ",
         "which makes you upset."),
  #-#
  "TQ_q33",
  "I have more difficulty following a conversation because of the noises.",
  #-#
  "TQ_q34",
  "I find it harder to relax because of the noises.",
  #-#
  "TQ_q35",
  "My noises are often so bad that I cannot ignore them.",
  #-#
  "TQ_q36",
  "It takes me longer to get to sleep because of the noises.",
  #-#
  "TQ_q37",
  "I sometimes get very angry when I think about having the noises.",
  #-#
  "TQ_q38",
  "I find it harder to use the telephone because of the noises.",
  #-#
  "TQ_q39",
  "I am more liable to feel low because of the noises.",
  #-#
  "TQ_q40",
  paste0("I am able to forget about the noises when I am doing something ",
         "interesting."),
  #-#
  "TQ_q41",
  "Because of the noises life seems to be getting on top of me.",
  #-#
  "TQ_q42",
  "I have always been sensitive about trouble with my ears.",
  #-#
  "TQ_q43",
  "I often think about whether the noises will ever go away.",
  #-#
  "TQ_q44",
  "I can imagine coping with the noises.",
  #-#
  "TQ_q45",
  "The noises never \"let up\".",
  #-#
  "TQ_q46",
  "A stronger person might be better at accepting this problem.",
  #-#
  "TQ_q47",
  "I am a victim of my noises.",
  #-#
  "TQ_q48",
  "The noises have affected my concentration.",
  #-#
  "TQ_q49",
  "The noises are one of those problems in life you have to live with.",
  #-#
  "TQ_q50",
  "Because of the noises I am unable to enjoy the radio or television.",
  #-#
  "TQ_q51",
  "The noises sometimes produce a bad headache.",
  #-#
  "TQ_q52",
  "I have always been a light sleeper.",
  #-#
  "TQ_score",
  "TQ total sum score",
  #-#
  "TQ_emotional_distress",
  "TQ \"emotional distress\" subscale",
  #-#
  "TQ_cognitive_distress",
  "TQ \"cognitive distress\" subscale",
  #-#
  "TQ_intrusiveness",
  "TQ \"intrusiveness\" subscale",
  #-#
  "TQ_auditory_perceptual_difficulties",
  "TQ \"auditory perceptual difficulties\" subscale",
  #-#
  "TQ_sleep_disturbances",
  "TQ \"sleep disturbances\" subscale",
  #-#
  "TQ_somatic_complaints",
  "TQ \"somatic complaints\" subscale",
  #-#
  # TSCHQ ----
  "TSCHQ_lvs",
  NA_character_,
  #-#
  "TSCHQ_months_between_begin_tinnitus_and_visit_time",
  NA_character_,
  #-#
  "TSCHQ_months_since_begin_tinnitus",
  NA_character_,
  #-#
  "TSCHQ_q01_age",
  "Patient age at examination (in years)",
  #-#
  "TSCHQ_q02_sex",
  "Patient gender",
  #-#
  "TSCHQ_q03_handedness",
  "Patient handedness",
  #-#
  "TSCHQ_q04_family",
  "Family history of tinnitus complaints",
  #-#
  "TSCHQ_q04_1_family_additional",
  "Family history of tinnitus complaints: additional statements",
  #-#
  "TSCHQ_q05_begin_tinnitus",
  "Initial onset: when did you first experience your tinnitus?",
  #-#
  "TSCHQ_q05_1_begin_tinnitus_additional",
  "Initial onset: if not exactly known",
  #-#
  "TSCHQ_q06_begin_perception",
  "How did you perceive the beginning?",
  #-#
  "TSCHQ_q07_begin_correlation",
  "Was the initial onset of your tinnitus related to:",
  #-#
  "TSCHQ_q08_pulsating",
  "Does your tinnitus seem to PULSATE?",
  #-#
  "TSCHQ_q09_perception",
  "Where do you perceive your tinnitus?",
  #-#
  "TSCHQ_q10_history",
  "How does your tinnitus manifest itself over time?",
  #-#
  "TSCHQ_q11_daily_volume",
  "Does the LOUDNESS of the tinnitus vary from day to day?",
  #-#
  "TSCHQ_q12_personal_volume",
  "Describe the LOUDNESS of your tinnitus using a scale from 1-100.",
  #-#
  "TSCHQ_q13_tone_perception",
  "Please descibe in your own words what your tinnitus usually sounds like:",
  #-#
  "TSCHQ_q14_tone_type",
  "Does your tinnitus more sound like a tone or more like noise?",
  #-#
  "TSCHQ_q15_tone_frequency",
  "Please describe the PITCH of your tinnitus:",
  #-#
  "TSCHQ_q16_awareness",
  paste0("What percent of your total awake time, over the last month, have ",
         "you been aware of your tinnitus?"),
  #-#
  "TSCHQ_q17_angerness",
  paste0("What percent of your total awake time, over the last month, have ",
         "you been annoyed, distressed, or irritated of your tinnitus?"),
  #-#
  "TSCHQ_q18_treatment_count",
  paste0("How many different treatments have you undergone because of your ",
         "tinnitus?"),
  #-#
  "TSCHQ_q19_context_volume",
  paste0("Is your tinnitus reduced by music or by certain types of ",
         "environmental sounds such as the noise of a waterfall or the ",
         "noise of running water when you are standing in the shower?"),
  #-#
  "TSCHQ_q20_context_change",
  "Does the presence of loud noise make your tinnitus worse?",
  #-#
  "TSCHQ_q21_head_change",
  paste0("Does any head and neck movement (e.g. moving the jaw forward or",
         "clenching the teeth), or having your arms/hands or head touched, ",
         "affect your tinnitus?"),
  #-#
  "TSCHQ_q22_nap_change",
  "Does taking a nap during the day affect your tinnitus?",
  #-#
  "TSCHQ_q23_sleep_correlation",
  paste0("Is there any relationship between sleep at night and your ",
         "tinnitus during the day?"),
  #-#
  "TSCHQ_q24_stress_correlation",
  "Does stress influence your tinnitus?",
  #-#
  "TSCHQ_q25_medication",
  "Does medication have an effect on your tinnitus?",
  #-#
  "TSCHQ_q26_hear_problems",
  "Do you think you have a hearing problem?",
  #-#
  "TSCHQ_q27_hear_helps",
  "Do you wear hearing aids?",
  #-#
  "TSCHQ_q28_noise_sensitive",
  paste0("Do you have a problem tolerating sounds because they often seem ",
         "much too loud? That is, do you often find too loud or hurtful sounds ",
         "which other people around you find quite comfortable?"),
  #-#
  "TSCHQ_q29_noise_dependent",
  "Do sounds cause you pain or physical discomfort?",
  #-#
  "TSCHQ_q30_headache",
  "Do you suffer from headache?",
  #-#
  "TSCHQ_q31_bogus",
  "Do you suffer from vertigo or dizziness?",
  #-#
  "TSCHQ_q32_jaw_problems",
  "Do you suffer from temporomandibular disorder?",
  #-#
  "TSCHQ_q33_nape_problems",
  "Do you suffer from neck pain?",
  #-#
  "TSCHQ_q34_other_problems",
  "Do you suffer from other pain syndromes?",
  #-#
  "TSCHQ_q35_psychological_treatment",
  "Are you currently under treatment for psychiatric problems?",
  #-#
  "TSCHQ_q36_1_otologic_additional",
  NA_character_,
  #-#
  "TSCHQ_q36_otologic",
  NA_character_,
  #-#
  # TSQ ----
  "TSQ_lvs",
  NA_character_,
  #-#
  "TSQ_q1",
  "How much of a problem is your tinnitus at present?",
  #-#
  "TSQ_q2",
  "How STRONG or LOUD is your tinnitus at present?",
  #-#
  "TSQ_q3",
  "How UNCOMFORTABLE is your tinnitus at present, if everything around you is quiet?",
  #-#
  "TSQ_q4",
  "How ANNOYING is your tinnitus at present?",
  #-#
  "TSQ_q5",
  "How easy is it for you to IGNORE your tinnitus at present?",
  #-#
  "TSQ_q6",
  "Do you feel frustrated because of your tinnitus?",
  #-#
  # WHOQOL ----
  "WHOQOL_domain01",
  "Domain \"physical health\"",
  #-#
  "WHOQOL_domain02",
  "Domain \"psychological\"",
  #-#
  "WHOQOL_domain03",
  "Domain \"social relationships\"",
  #-#
  "WHOQOL_domain04",
  "Domain \"environment\"",
  #-#
  "WHOQOL_lvs",
  NA_character_,
  #-#
  "WHOQOL_more_20pct_missing",
  NA_character_,
  #-#
  "WHOQOL_q01",
  "How would you rate your quality of life?",
  #-#
  "WHOQOL_q02",
  "How satisfied are you with your health?",
  #-#
  "WHOQOL_q03",
  paste0("To what extent do you feel that physical pain prevents you from ",
         "doing what you need to do?"),
  #-#
  "WHOQOL_q04",
  paste0("How much do you need any medical treatment to function in your ",
         "daily life?"),
  #-#
  "WHOQOL_q05",
  "How much do you enjoy life?",
  #-#
  "WHOQOL_q06",
  "To what extent do you feel your life to be meaningful?",
  #-#
  "WHOQOL_q07",
  "How well are you able to concentrate?",
  #-#
  "WHOQOL_q08",
  "How safe do you feel in your daily life?",
  #-#
  "WHOQOL_q09",
  "How healthy is your physical environment?",
  #-#
  "WHOQOL_q10",
  "Do you have enough energy for everyday life?",
  #-#
  "WHOQOL_q11",
  "Are you able to accept your bodily appearance?",
  #-#
  "WHOQOL_q12",
  "Do you have enough money to meet your needs?",
  #-#
  "WHOQOL_q13",
  paste0("How available to you is the information that you need in your ",
         "day-to-day life?"),
  #-#
  "WHOQOL_q14",
  "To what extent do you have the opportunity for leisure activities?",
  #-#
  "WHOQOL_q15",
  "How well are you able to get around?",
  #-#
  "WHOQOL_q16",
  "How satisfied are you with your sleep?",
  #-#
  "WHOQOL_q17",
  paste0("How satisfied are you with your ability to perform your daily ",
         "living activities?"),
  #-#
  "WHOQOL_q18",
  "How satisfied are you with your capacity for work?",
  #-#
  "WHOQOL_q19",
  "How satisfied are you with yourself?",
  #-#
  "WHOQOL_q20",
  "How satisfied are you with your personal relationships?",
  #-#
  "WHOQOL_q21",
  "How satisfied are you with your sex life?",
  #-#
  "WHOQOL_q22",
  "How satisfied are you with the support you get from your friends?",
  #-#
  "WHOQOL_q23",
  "How satisfied are you with the conditions of your living place?",
  #-#
  "WHOQOL_q24",
  "How satisfied are you with your access to health services?",
  #-#
  "WHOQOL_q25",
  "How satisfied are you with your transport?",
  #-#
  "WHOQOL_q26",
  paste0("How often do you have negative feelings such as blue mood, ",
         "despair, anxiety, depression?")
)

# dd_cats ----

dd_cats <- tribble(
  ~item, ~value,

  c(".META_visit_type"),
  c("S" = "screening",
    "B" = "baseline",
    "I" = "interim visit",
    "FV" = "final visit",
    "FU" = "followup"),
  c(".META_treatment_code"),
  c("001-001" = "Drug.intervention.-.eperisone.(Myonal)",
    "001-002" = "Drug intervention - mirtazapin",
    "001-003" = "Drug intervention - pregabalin (Lyrica)",
    "001-004" = "Drug intervention - odansetron (Zofran)",
    "001-005" = "Drug intervention - caroverine",
    "001-006" = "Electrical intervention - tDCS",
    "001-007" = "rTMS-1 / 20/1 Hz (offen) Studie abgeschlossen",
    "001-008" = "rTMS-2 / 1/1 Hz",
    "001-009" = "rTMS-3 / 1 Hz",
    "001-010" = "Naltrexon",
    "001-011" = "Lithiumcarbonat",
    "001-012" = "Cyclobenzaprin",
    "001-013" = "valdoxan",
    "001-014" = "rTMS-4 / 1 Hz (4000)",
    "001-015" = "rTMS-5 / 20/1 Hz (2000)",
    "001-016" = "rTMS-6 / 1 Hz verum",
    "001-017" = "rTMS-7 / 1 Hz placebo",
    "001-018" = "rTMS-8 / 6/1 Hz",
    "001-019" = "rTMS-9 / 1 Hz",
    "001-020" = "rTMS-10 / 1 Hz + Madopar (mit Med)",
    "001-021" = "rTMS-11 / 1 Hz + Madopar (ohne Med)",
    "001-022" = "rTMS-12 / 1 Hz + Elontril (mit Med)",
    "001-023" = "rTMS-13 / individualisiert",
    "001-024" = "tVNS",
    "001-025" = "Naltrexon",
    "001-026" = "rTMS-14 / 20+1 Hz (4000)",
    "001-027" = "rTMS-15 / 1 Hz (offen)",
    "001-028" = "rTMS-17 / 1 Hz (crossover)",
    "001-029" = "rTMS-16 / 1 Hz (crossover)",
    "001-030" = "rTMS-18 / 1 Hz (crossover)",
    "001-031" = "rTMS-1 / 20/1 Hz (offen) alte Daten",
    "001-032" = "tVNS II",
    "001-033" = "triple 20/1/1 Hz",
    "001-034" = "Individuelles TMS",
    "001-035" = "flexibles TMS, aus verschiedenen Gründen",
    "001-036" = "CBT cognitive-behavioral therapy",
    "001-037" = "TiCDC + 1Hz",
    "001-038" = "20 + 1",
    "001-039" = "Triple II",
    "001-040" = "Cochlearimplantat",
    "001-041" = "Triple II Kontrollgruppe",
    "001-042" = "Relax",
    "001-043" = "tRNS / Rauschstrom",
    "001-044" = "Kurzbehandlung 20+1, 4000 Stimuli",
    "001-045" = "Kurzbehandlung 20+1+1 Hz, 4000 Stimuli",
    "001-046" = "20+1 Hz, 4000 Stimuli +rPMS",
    "001-047" = "Kurzbehandlung. tRNS offen",
    "001-048" = "Hörgerätestudie",
    "001-049" = "Hörgerätestudie",
    "001-050" = "Kurzbehandlung 20+1, 4000 Stimuli + rPMS",
    "001-051" = "tRNS 2",
    "001-052" = "4-Wochen-Studie: 20+1+1 Hz, 3000 Stimuli",
    "001-053" = "4-Wochen-Studie: 20+20+20 Hz, 3000 Stimuli",
    "001-054" = "Kurzbehandlung: 20+1+1 Hz, 3000 Stimuli offen",
    "001-055" = "auditorische Stimulation",
    "001-056" = "Kurzbehandl.: 20+1 Hz, 4000 Stimuli, 4 Wochen",
    "001-057" = "Kurzbehandl. Individuell",
    "001-058" = "Kurzbehandlung 20+1+1 Hz, 3000 Stimuli + rPMS",
    "001-059" = "Kurzbehandlung 20+1 Hz, 4000 Stimuli + rPMS",
    "001-060" = "Kurzbehandlung: 20+1+1 Hz, 3000 Stimuli offen",
    "001-061" = "Lidokain-Injektion verum",
    "001-062" = "Lidokain-Injektion placebo",
    "001-063" = "Kurzbehandlung 20+1+1 Hz, 3000 Stimuli + rPMS",
    "001-064" = "4-Wochen-Studie: 20+1+1 Hz, 3000 Stimuli (2 Wochen mit TMS behandelt)",
    "001-065" = "4-Wochen-Studie: 20+20+20 Hz, 3000 Stimuli (2 Wochen mit TMS behandelt)",
    "001-066" = "Longitudinalstudie (Jorge)",
    "001-067" = "indiTMS",
    "001-068" = "keine standardisierten Behandlungen",
    "001-069" = "Clomipramin (b Hyperakusis)",
    "001-070" = "Stromrichtung TMS",
    "001-071" = "Stromrichtung TMS",
    "001-072" = "Indi-TMS Nexstim",
    "001-073" = "TMS Erhaltungstherapie",
    "001-074" = "Quarantäne2020",
    "001-999" = "Patient seen only once for cross sectional study"
  ),
  #-#

  c("AUDIO_left_hearing_loss",
    "AUDIO_right_hearing_loss"),
  c("-1" = "no information",
    "0" = "normal (0-20 dB HL)",
    "1" = "AHZ (21-60 dB HL)",
    "2" = "IHZ (>60 dB HL)"
  ),
  c("AUDIO_tinnitus_matching "),
  c("-1" = "no information",
    "0" = "right",
    "1" = "left",
    "2" = "both sides"
  ),
  #-#

  c("CGI_q1"),
  c("1" = "very much better",
    "2" = "much better",
    "3" = "minimally better",
    "4" = "no change",
    "5" = "minimally worse",
    "6" = "much worse",
    "7" = "very much worse"),
  #-#

  c("MDI_q01", "MDI_q02", "MDI_q03", "MDI_q04", "MDI_q05", "MDI_q06",
    "MDI_q07", "MDI_q08a", "MDI_q08b", "MDI_q09", "MDI_q10a", "MDI_q10b"),
  c("-1" = "no information",
    "0" = "At no time",
    "1" = "Some of the time",
    "2" = "Slightly less than half the time",
    "3" = "Slightly more than half the time",
    "4" = "Most of the time",
    "5" = "All the time"),
  #-#

  c("MINITQ_q01", "MINITQ_q02", "MINITQ_q03", "MINITQ_q04", "MINITQ_q05",
    "MINITQ_q06", "MINITQ_q07", "MINITQ_q08", "MINITQ_q09", "MINITQ_q10",
    "MINITQ_q11", "MINITQ_q12",
    "TQ_q02", "TQ_q03", "TQ_q04", "TQ_q05", "TQ_q06", "TQ_q08", "TQ_q09",
    "TQ_q10", "TQ_q11", "TQ_q12", "TQ_q13", "TQ_q14", "TQ_q15", "TQ_q16",
    "TQ_q17", "TQ_q18", "TQ_q19", "TQ_q20", "TQ_q21", "TQ_q22", "TQ_q23",
    "TQ_q24", "TQ_q25", "TQ_q26", "TQ_q27", "TQ_q28", "TQ_q29", "TQ_q30",
    "TQ_q31", "TQ_q32", "TQ_q33", "TQ_q34", "TQ_q35", "TQ_q36", "TQ_q37",
    "TQ_q38", "TQ_q39", "TQ_q40", "TQ_q41", "TQ_q42", "TQ_q43", "TQ_q45",
    "TQ_q46", "TQ_q47", "TQ_q48", "TQ_q49", "TQ_q50", "TQ_q51", "TQ_q52"),
  c("-1" = "no information",
    "0" = "not true",
    "1" = "partly true",
    "2" = "true"),
  #-#

  c("TQ_q01", "TQ_q07", "TQ_q44"),
  c("-1" = "no information",
    "0" = "true",
    "1" = "partly true",
    "2" = "not true"),
  #-#

  c("TBF12_q01", "TBF12_q02", "TBF12_q03", "TBF12_q04", "TBF12_q05",
    "TBF12_q06", "TBF12_q07", "TBF12_q08", "TBF12_q09", "TBF12_q10",
    "TBF12_q11", "TBF12_q12"),
  c("-1" = "no information",
    "0" = "Never",
    "1" = "Sometimes",
    "2" = "Often"),
  #-#

  c("TFI_q01", "TFI_q03"),
  c("-1" = "no information",
    "0" = "0% = none of the time",
    "100" = "100% = all of the time"),
  c("TFI_q02"),
  c("-1" = "no information",
    "0" = "not at all strong or loud",
    "10" = "extremely strong or loud"),
  c("TFI_q04"),
  c("-1" = "no information",
    "0" = "very much in control",
    "10" = "never in control"),
  c("TFI_q05"),
  c("-1" = "no information",
    "0" = "very easy to cope",
    "10" = "impossible to cope"),
  c("TFI_q06"),
  c("-1" = "no information",
    "0" = "very easy to ignore",
    "10" = "impossible to ignore"),
  c("TFI_q07", "TFI_q08", "TFI_q09", "TFI_q13", "TFI_q14", "TFI_q15",
    "TFI_q16", "TFI_q17", "TFI_q18", "TFI_q19", "TFI_q20", "TFI_q21"),
  c("-1" = "no information",
    "0" = "did not interfere",
    "10" = "completely interfered"),
  c("TFI_q10", "TFI_q11", "TFI_q22"),
  c("-1" = "no information",
    "0" = "never had difficulty",
    "10" = "always had difficulty"),
  c("TFI_q12"),
  c("-1" = "no information",
    "0" = "none of the time",
    "10" = "all of the time"),
  c("TFI_q23"),
  c("-1" = "no information",
    "0" = "not at all anxious or worried",
    "10" = "extremely anxious or worried"),
  c("TFI_q24"),
  c("-1" = "no information",
    "0" = "not at all bothered or upset",
    "10" = "extremely bothered or upset"),
  c("TFI_q25"),
  c("-1" = "no information",
    "0" = "not at all depressed",
    "10" = "extremely depressed"),
  #-#

  c("THI_q01", "THI_q02", "THI_q03", "THI_q04", "THI_q05", "THI_q06",
    "THI_q07", "THI_q08", "THI_q09", "THI_q10", "THI_q11", "THI_q12",
    "THI_q13", "THI_q14", "THI_q15", "THI_q16", "THI_q17", "THI_q18",
    "THI_q19", "THI_q20", "THI_q21", "THI_q22", "THI_q23", "THI_q24",
    "THI_q25"),
  c("-1" = "no information",
    "0" = "NO",
    "2" = "sometimes",
    "4" = "YES"),
  #-#

  "TSCHQ_q02_sex", c("0" = "male", "1" = "female"),
  "TSCHQ_q03_handedness",
  c("-1" = "no information", "0" = "right", "1" = "left", "2" = "both sides"),
  "TSCHQ_q04_family", c("-1" = "no information", "0" = "YES", "1" = "NO"),
  "TSCHQ_q04_1_family_additional",
  c("0" = "parents", "1" = "siblings", "2" = "children"),
  "TSCHQ_q05_1_begin_tinnitus_additional",
  c("0" = "date is missing",
    "1" = "day and month are missing",
    "2" = "date complete"),
  "TSCHQ_q06_begin_perception",
  c("-1" = "no information", "0" = "gradual", "1" = "abrupt"),
  "TSCHQ_q07_begin_correlation",
  c("0" = "loud blast of sound",
    "1" = "stress",
    "2" = "whiplash",
    "3" = "head trauma",
    "4" = "change in hearing",
    "5" = "other: [INPUT]"),
  "TSCHQ_q08_pulsating",
  c("-1" = "no information",
    "0" = "YES with heart beat",
    "1" = "YES different from heart beat",
    "2" = "NO"),
  "TSCHQ_q09_perception",
  c("-1" = "no information",
    "0" = "right ear",
    "1" = "left ear",
    "2" = "both ears, worse in left",
    "3" = "both ears, worse in right",
    "4" = "both ears, equally",
    "5" = "inside the head",
    "6" = "elsewhere"),
  "TSCHQ_q10_history",
  c("-1" = "no information", "0" = "intermittent", "1" = "constant"),
  "TSCHQ_q11_daily_volume",
  c("-1" = "no information", "0" = "YES", "1" = "NO"),
  "TSCHQ_q12_personal_volume",
  c("999" = "missing", "1" = "very faint", "100" = "very loud"),
  "TSCHQ_q14_tone_type",
  c("-1" = "no information", "0" = "tone", "1" = "noise", "2" = "crickets",
    "3" = "others"),
  "TSCHQ_q15_tone_frequency",
  c("-1" = "no information",
    "0" = "very high freq.",
    "1" = "high freq.",
    "2" = "medium freq.",
    "3" = "low freq."),
  c("TSCHQ_q16_awareness", "TSCHQ_q17_angerness"),
  c("999" = "missing", "1" = "non of the time", "100" = "all the time"),
  "TSCHQ_q18_treatment_count",
  c("0" = "none",
    "1" = "1",
    "2" = "2 - 4",
    "3" = "5 and more",
    "4" = "several",
    "5" = "many"),
  c("TSCHQ_q19_context_volume", "TSCHQ_q20_context_change",
    "TSCHQ_q21_head_change", "TSCHQ_q23_sleep_correlation",
    "TSCHQ_q29_noise_dependent"),
  c("-1" = "no information",
    "0" = "YES",
    "1" = "NO",
    "2" = "I don't know."),
  c("TSCHQ_q22_nap_change", "TSCHQ_q24_stress_correlation"),
  c("-1" = "no information",
    "0" = "worsens my tinnitus",
    "1" = "reduces my tinnitus",
    "2" = "has no effect"),
  "TSCHQ_q26_hear_problems",
  c("-1" = "no information", "0" = "YES", "1" = "NO"),
  "TSCHQ_q27_hear_helps",
  c("-1" = "no information",
    "0" = "right",
    "1" = "left",
    "2" = "both",
    "3" = "none"),
  "TSCHQ_q28_noise_sensitive",
  c("-1" = "no information",
    "0" = "never",
    "1" = "rarely",
    "2" = "sometimes",
    "3" = "usually",
    "4" = "always"),
  c("TSCHQ_q30_headache", "TSCHQ_q31_bogus", "TSCHQ_q32_jaw_problems",
    "TSCHQ_q33_nape_problems", "TSCHQ_q34_other_problems",
    "TSCHQ_q35_psychological_treatment", "TSCHQ_q36_otologic"),
  c("-1" = "no information",
    "0" = "YES",
    "1" = "NO"),
  #-#

  "TSQ_q1",
  c("-1" = "no information",
    "0" = "not a problem",
    "1" = "a small problem",
    "2" = "a moderate problem",
    "3" = "a big problem",
    "4" = "a very big problem"
  ),
  "TSQ_q2",
  c("-1" = "no information",
    "0" = "not at all strong or loud",
    "10" = "extremely strong or loud"),
  "TSQ_q3",
  c("-1" = "no information",
    "0" = "not at all uncomfortable",
    "10" = "extremely uncomfortable"),
  "TSQ_q4",
  c("-1" = "no information",
    "0" = "not at all annoying",
    "10" = "extremely annoying"),
  "TSQ_q5",
  c("-1" = "no information",
    "0" = "very easy to ignore",
    "10" = "impossible to ignore"),
  "TSQ_q6",
  c("-1" = "no information",
    "0" = "not at all unpleasant",
    "10" = "extremely unpleasant"),
  #-#

  c("WHOQOL_q01", "WHOQOL_q15"),
  c("-1" = "no information",
    "1" = "very poor",
    "2" = "poor",
    "3" = "neither poor nor good",
    "4" = "good",
    "5" = "very good"),
  c("WHOQOL_q02", "WHOQOL_q16", "WHOQOL_q17", "WHOQOL_q18", "WHOQOL_q19",
    "WHOQOL_q20", "WHOQOL_q21", "WHOQOL_q22", "WHOQOL_q23", "WHOQOL_q24",
    "WHOQOL_q25"),
  c("-1" = "no information",
    "1" = "very dissatisfied",
    "2" = "dissatisfied",
    "3" = "neither satisfied nor dissatisfied",
    "4" = "satisfied",
    "5" = "very satisfied"),
  c("WHOQOL_q03", "WHOQOL_q04"),
  c("-1" = "no information",
    "1" = "an extreme amount",
    "2" = "very much",
    "3" = "a moderate amount",
    "4" = "a little",
    "5" = "not at all"),
  c("WHOQOL_q05", "WHOQOL_q06", "WHOQOL_q07", "WHOQOL_q08", "WHOQOL_q09"),
  c("-1" = "no information",
    "1" = "not at all",
    "2" = "a little",
    "3" = "a moderate amount",
    "4" = "very much",
    "5" = "an extreme amount"),
  c("WHOQOL_q10", "WHOQOL_q11", "WHOQOL_q12", "WHOQOL_q13", "WHOQOL_q14"),
  c("-1" = "no information",
    "1" = "not at all",
    "2" = "a little",
    "3" = "moderately",
    "4" = "mostly",
    "5" = "completely"),
  "WHOQOL_q26",
  c("-1" = "no information",
    "1" = "always",
    "2" = "very often",
    "3" = "quite often",
    "4" = "seldom",
    "5" = "never"
  )
  #-#
)

# cat(paste0('"', names(df_new_features), '"'), sep = ',\n"",\n#-#\n')

data_dict <- dd_stem %>% left_join(dd_cats %>% unnest(cols = item), by = "item")
usethis::use_data(data_dict, overwrite = TRUE)
