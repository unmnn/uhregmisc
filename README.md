
# uhregmisc

Miscellaneous Helper Functions For The Univ. Regensburg Tinnitus Data.

**Important:** For most of the functions to work, you would need to put
into the `data-raw/` folder the original dataset (`200622_uhreg.xlsx`)
which cannot be uploaded to GitHub due to copyright reasons.

## Overview

  - `data-raw/uhreg.R`: preprocessing script for the raw UHREG data
  - datasets `uhreg` and `data_dict` (+ json export at
    `inst/extdata/data_dict.json`)
  - function `discretize_score()` for discretizing a numeric
    questionnaire score according to predefined cutoff values from
    literature.
  - Shiny app to explore missingness / available data.

## Installation

``` r
remotes::install_github("unmnn/uhregmisc")
```

``` r
library(uhregmisc)
```

## Shiny app on data missingness

<img src="app-ume/app-ume.png" width="80%" />

Provides an overview of missing data patterns. You can specify a data
subset based on:

  - visit type: screening, baseline, interim visit, final visit and/or
    followup
  - treatment (10 most frequent treatment types are selectable)
  - gender
  - age range

Additionally, you can choose to order questionnaires (y-axis) either by
mutual missingness (determined by a hierarchical clustering) or just
alphabetically by their name.

### How to run app

``` r
# When running the first time, create the necessary pre-processed dataset with:
source("app-ume/ume_prep-data.R")
# Afterwards, the folder `app-ume` should contain the file `data.rds`.
# Then, just run the app via:
shiny::runApp("app-ume")
```

## Data preprocessing steps

The script `data-raw/uhreg.R` preprocesses the UHREG data.

  - part of column name representing the questionnaire is written in
    caps
  - establish consistent name convention: prefix of variable name (part
    until first underscore) represents the name of the corresponding
    questionnaire
      - example: `TQ_q01` → `TQ` questionnaire
      - meta variables, e.g. patient ID or treatment type, have the
        prefix `.META`
  - some variables are renamed for consistency of chronology,
    e.g. `TSCHQ_q36_1_otologic_additional` instead of
    `TSCHQ_q361_otologic_additional`
  - abbreviations in names: `q` instead of `question`, `lvs` instead of
    `last_validation_status`
      - example: `TBF12_q10` instead of `TBF12_question10`
  - in column names, zero-padding is added to allow for alphabetical
    ordering, e.g. `TBF12_q01` instead of `TBF12_q1` (there is also a
    `TBF12_q10`)
  - all BDI columns are removed due to complete missingness
  - variable types are converted where appropriate:
      - `TSCHQ_q02_sex` to `factor`
      - `.META_patient_id` to `character`
      - `.META_visit_day`, `TSCHQ_q05_begin_tinnitus` to `date`
  - `-1` values are replaced with `NA_integer_` where appropriate
  - some (sub-)scales are created:
      - TFI subscales: intrusive, sense of control, cognitive, sleep,
        auditory, relaxation, quality of life, emotional
      - TQ subscales: emotional distress, cognitive distress,
        intrusiveness, auditory perceptual difficulties, sleep
        disturbances, somatic complaints
      - MDI: depression categorization

## Open questions

  - How to deal with the huge variety of treatment pathways?

<!-- end list -->

    109 unique treatment pathways
    
                                   S                         S-B-FV-FU 
                                  869                                38 
                                 FV-B                            S-B-FV 
                                   32                                24 
                                 B-FV                               S-S 
                                   22                                17 
                         B-FV-I-I-I-S                     B-FV-FU-FU-FU 
                                   16                                15

<!-- - Is there any documentation for the audiological assessment? There are a lot of negative values (e.g. -1 for AUDIO_duration) and "repdigits" (999, 99999) - I assume they have a special meaning. -->

  - What do the columns with “last\_validation\_status” mean? What do
    their values (-1, 0, 1) mean?
  - Documentation for “v\_exp\_tschq\_q36\_otologic” and
    “v\_exp\_tschq\_q361\_otologic\_additional”

## TODOS

  - Improve rudimentary documentation for `uhreg` and `data_dict`
  - Add function that dummifies categorical variables

## `data_dict`

``` r
library(dplyr)
library(purrr)
data_dict
```

    ## # A tibble: 294 x 4
    ##    variable                     variable_original                              description                                   value     
    ##    <chr>                        <chr>                                          <chr>                                         <list>    
    ##  1 .META_patient_id             new_ID                                         Patient ID                                    <NULL>    
    ##  2 .META_treatment_code         treatment_code                                 Treatment code                                <chr [75]>
    ##  3 .META_visit_day              visit_day                                      Day of visit                                  <NULL>    
    ##  4 .META_visit_type             visit_type                                     Type of visit                                 <chr [5]> 
    ##  5 AUDIO_duration               audiological_examination_duration              Audiological examination: duration in seconds <chr [1]> 
    ##  6 AUDIO_left_frequency_loss_01 audiological_examination_left_frequency_loss_1 Left ear: hearing loss at frequency 125Hz     <chr [2]> 
    ##  7 AUDIO_left_frequency_loss_02 audiological_examination_left_frequency_loss_2 Left ear: hearing loss at frequency 250Hz     <chr [2]> 
    ##  8 AUDIO_left_frequency_loss_03 audiological_examination_left_frequency_loss_3 Left ear: hearing loss at frequency 500Hz     <chr [2]> 
    ##  9 AUDIO_left_frequency_loss_04 audiological_examination_left_frequency_loss_4 Left ear: hearing loss at frequency 1kHz      <chr [2]> 
    ## 10 AUDIO_left_frequency_loss_05 audiological_examination_left_frequency_loss_5 Left ear: hearing loss at frequency 2kHz      <chr [2]> 
    ## # ... with 284 more rows

``` r
var <- "TSCHQ_q09_perception"
data_dict %>% filter(variable == var) %>% pull(description)
```

    ## [1] "Where do you perceive your tinnitus?"

``` r
data_dict %>% filter(variable == var) %>% pluck("value", 1)
```

    ##                          -1                           0                           1                           2                           3                           4 
    ##            "no information"                 "right ear"                  "left ear"  "both ears, worse in left" "both ears, worse in right"        "both ears, equally" 
    ##                           5                           6 
    ##           "inside the head"                 "elsewhere"

## `uhreg` overview

``` r
skimr::skim_without_charts(uhreg)
```

|                                                  |       |
| :----------------------------------------------- | :---- |
| Name                                             | uhreg |
| Number of rows                                   | 2350  |
| Number of columns                                | 295   |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |       |
| Column type frequency:                           |       |
| character                                        | 7     |
| Date                                             | 2     |
| factor                                           | 2     |
| numeric                                          | 284   |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |       |
| Group variables                                  | None  |

Data summary

**Variable type: character**

| skim\_variable                      | n\_missing | complete\_rate | min | max | empty | n\_unique | whitespace |
| :---------------------------------- | ---------: | -------------: | --: | --: | ----: | --------: | ---------: |
| .META\_patient\_id                  |          0 |           1.00 |   1 |   4 |     0 |      1214 |          0 |
| .META\_treatment\_code              |          0 |           1.00 |   7 |   7 |     0 |        25 |          0 |
| TSCHQ\_q04\_1\_family\_additional   |       2050 |           0.13 |   1 |   5 |     0 |         7 |          0 |
| TSCHQ\_q07\_begin\_correlation      |        993 |           0.58 |   1 | 287 |     0 |       496 |          0 |
| TSCHQ\_q13\_tone\_perception        |        992 |           0.58 |   1 | 442 |     0 |      1018 |          0 |
| TSCHQ\_q25\_medication              |       1950 |           0.17 |   3 | 364 |     0 |       324 |          0 |
| TSCHQ\_q36\_1\_otologic\_additional |       2045 |           0.13 |   2 |  37 |     0 |         2 |          0 |

**Variable type: Date**

| skim\_variable              | n\_missing | complete\_rate | min        | max        | median     | n\_unique |
| :-------------------------- | ---------: | -------------: | :--------- | :--------- | :--------- | --------: |
| .META\_visit\_day           |          0 |           1.00 | 2016-01-03 | 2020-10-23 | 2018-01-21 |       928 |
| TSCHQ\_q05\_begin\_tinnitus |       1197 |           0.49 | 1960-01-01 | 2020-07-06 | 2013-04-01 |       587 |

**Variable type: factor**

| skim\_variable     | n\_missing | complete\_rate | ordered | n\_unique | top\_counts                           |
| :----------------- | ---------: | -------------: | :------ | --------: | :------------------------------------ |
| .META\_visit\_type |          0 |           1.00 | FALSE   |         5 | S: 1141, FV: 382, B: 372, FU: 278     |
| MDI\_depression    |        583 |           0.75 | FALSE   |         4 | no : 1555, sev: 142, mil: 49, mod: 21 |

**Variable type: numeric**

| skim\_variable                                            | n\_missing | complete\_rate |    mean |       sd |    p0 |     p25 |     p50 |     p75 |   p100 |
| :-------------------------------------------------------- | ---------: | -------------: | ------: | -------: | ----: | ------: | ------: | ------: | -----: |
| AUDIO\_duration                                           |       2346 |           0.00 |  247.00 |   504.01 |   \-9 |  \-5.25 |  \-3.00 |  249.25 |   1003 |
| AUDIO\_left\_frequency\_loss\_01                          |       1385 |           0.41 |   13.99 |    82.44 |     0 |    5.00 |   10.00 |   15.00 |   2545 |
| AUDIO\_left\_frequency\_loss\_02                          |       1279 |           0.46 |   11.08 |    13.28 |   \-5 |    5.00 |    5.00 |   15.00 |    105 |
| AUDIO\_left\_frequency\_loss\_03                          |       1277 |           0.46 |   12.26 |    13.67 |   \-5 |    5.00 |   10.00 |   15.00 |    105 |
| AUDIO\_left\_frequency\_loss\_04                          |       1278 |           0.46 |   13.61 |    14.82 |   \-5 |    5.00 |   10.00 |   20.00 |    110 |
| AUDIO\_left\_frequency\_loss\_05                          |       1278 |           0.46 |   18.81 |    34.67 |   \-5 |    5.00 |   10.00 |   25.00 |    997 |
| AUDIO\_left\_frequency\_loss\_06                          |       1297 |           0.45 |   24.69 |    20.33 |     0 |   10.00 |   20.00 |   35.00 |    100 |
| AUDIO\_left\_frequency\_loss\_07                          |       1279 |           0.46 |   29.58 |    21.96 |   \-5 |   10.00 |   25.00 |   45.00 |    100 |
| AUDIO\_left\_frequency\_loss\_08                          |       1305 |           0.44 |   32.04 |    22.80 |  \-10 |   15.00 |   30.00 |   50.00 |    110 |
| AUDIO\_left\_frequency\_loss\_09                          |       1306 |           0.44 |   41.44 |   172.56 |   \-5 |   15.00 |   35.00 |   55.00 |   5555 |
| AUDIO\_left\_frequency\_loss\_10                          |       1591 |           0.32 |   44.32 |   146.55 |     0 |   15.00 |   40.00 |   60.00 |   4015 |
| AUDIO\_left\_frequency\_loss\_11                          |       1622 |           0.31 |   44.72 |    25.64 |     0 |   25.00 |   50.00 |   65.00 |     90 |
| AUDIO\_left\_frequency\_loss\_12                          |       1660 |           0.29 |   49.95 |    24.55 |     0 |   35.00 |   55.00 |   70.00 |     90 |
| AUDIO\_left\_frequency\_loss\_13                          |       1748 |           0.26 |   49.08 |    22.37 |   \-5 |   35.00 |   55.00 |   65.00 |     85 |
| AUDIO\_left\_frequency\_loss\_14                          |       1943 |           0.17 |   42.33 |    50.49 |     0 |   30.00 |   45.00 |   55.00 |    998 |
| AUDIO\_left\_hearing\_loss                                |       1310 |           0.44 |    0.94 |     0.67 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| AUDIO\_left\_maximal\_tinnitus\_frequency                 |       1567 |           0.33 | 8694.55 | 15721.60 |     0 | 2950.00 | 7100.00 | 9000.00 |  99999 |
| AUDIO\_left\_minimal\_masking\_level                      |       1634 |           0.30 |   31.66 |    20.57 |   \-4 |   18.00 |   30.00 |   46.00 |    100 |
| AUDIO\_left\_minimal\_tinnitus\_frequency                 |       1566 |           0.33 | 8617.26 | 15717.69 |     0 | 2500.00 | 6600.00 | 9000.00 |  99999 |
| AUDIO\_left\_tinntitus\_type                              |       1867 |           0.21 |    0.44 |     0.76 |     0 |    0.00 |    0.00 |    1.00 |      3 |
| AUDIO\_lvs                                                |       1074 |           0.54 |    0.66 |     0.47 |     0 |    0.00 |    1.00 |    1.00 |      1 |
| AUDIO\_residual\_inhibition                               |       2214 |           0.06 |    2.98 |     0.26 |     0 |    3.00 |    3.00 |    3.00 |      3 |
| AUDIO\_right\_frequency\_loss\_01                         |       1389 |           0.41 |   10.47 |    11.67 |   \-5 |    5.00 |    5.00 |   10.00 |     80 |
| AUDIO\_right\_frequency\_loss\_02                         |       1279 |           0.46 |   11.34 |    13.23 |   \-5 |    5.00 |    5.00 |   15.00 |    100 |
| AUDIO\_right\_frequency\_loss\_03                         |       1278 |           0.46 |   12.53 |    13.90 |  \-10 |    5.00 |   10.00 |   15.00 |    110 |
| AUDIO\_right\_frequency\_loss\_04                         |       1278 |           0.46 |   13.78 |    14.49 |     0 |    5.00 |   10.00 |   15.00 |    105 |
| AUDIO\_right\_frequency\_loss\_05                         |       1278 |           0.46 |   17.98 |    18.16 |     0 |    5.00 |   10.00 |   25.00 |    115 |
| AUDIO\_right\_frequency\_loss\_06                         |       1302 |           0.45 |   22.92 |    19.74 |   \-5 |   10.00 |   15.00 |   35.00 |    110 |
| AUDIO\_right\_frequency\_loss\_07                         |       1282 |           0.45 |   27.52 |    21.73 |  \-10 |   10.00 |   25.00 |   40.00 |    105 |
| AUDIO\_right\_frequency\_loss\_08                         |       1305 |           0.44 |   30.05 |    22.63 |  \-10 |   10.00 |   25.00 |   45.00 |    105 |
| AUDIO\_right\_frequency\_loss\_09                         |       1304 |           0.45 |   35.72 |    38.45 |  \-10 |   15.00 |   35.00 |   50.00 |    991 |
| AUDIO\_right\_frequency\_loss\_10                         |       1590 |           0.32 |   43.02 |   164.94 |   \-5 |   15.00 |   40.00 |   55.00 |   4530 |
| AUDIO\_right\_frequency\_loss\_11                         |       1620 |           0.31 |   44.67 |    44.23 |     0 |   20.00 |   45.00 |   65.00 |   1008 |
| AUDIO\_right\_frequency\_loss\_12                         |       1648 |           0.30 |   49.36 |    25.28 |   \-5 |   30.00 |   55.00 |   70.00 |     90 |
| AUDIO\_right\_frequency\_loss\_13                         |       1770 |           0.25 |   49.00 |    22.33 |   \-2 |   40.00 |   55.00 |   65.00 |     85 |
| AUDIO\_right\_frequency\_loss\_14                         |       1938 |           0.18 |   40.69 |    21.44 |     0 |   30.00 |   45.00 |   55.00 |    300 |
| AUDIO\_right\_hearing\_loss                               |       1291 |           0.45 |    0.92 |     0.69 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| AUDIO\_right\_maximal\_tinnitus\_frequency                |       1595 |           0.32 | 8909.82 | 16658.58 |     0 | 2575.00 | 6900.00 | 9000.00 | 100000 |
| AUDIO\_right\_minimal\_masking\_level                     |       1662 |           0.29 |   31.02 |    20.40 |   \-4 |   16.00 |   28.00 |   44.00 |     92 |
| AUDIO\_right\_minimal\_tinnitus\_frequency                |       1594 |           0.32 | 8840.16 | 16698.41 |     0 | 2000.00 | 6075.00 | 9000.00 | 106000 |
| AUDIO\_right\_tinnitus\_type                              |       1893 |           0.19 |    0.45 |     0.76 |     0 |    0.00 |    0.00 |    1.00 |      3 |
| AUDIO\_survey\_participation\_appropriateness             |       2161 |           0.08 |    1.43 |     0.91 |     0 |    0.00 |    2.00 |    2.00 |      2 |
| AUDIO\_tinnitus\_matching                                 |       1584 |           0.33 |    1.58 |     0.70 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| CGI\_lvs                                                  |       1540 |           0.34 |    1.00 |     0.00 |     1 |    1.00 |    1.00 |    1.00 |      1 |
| CGI\_q1                                                   |       1562 |           0.34 |    3.72 |     0.97 |     1 |    3.00 |    4.00 |    4.00 |      7 |
| MDI\_lvs                                                  |        573 |           0.76 |    0.99 |     0.10 |   \-1 |    1.00 |    1.00 |    1.00 |      1 |
| MDI\_q01                                                  |        591 |           0.75 |    1.92 |     1.43 |     0 |    1.00 |    1.00 |    3.00 |      5 |
| MDI\_q02                                                  |        592 |           0.75 |    1.65 |     1.48 |     0 |    1.00 |    1.00 |    3.00 |      5 |
| MDI\_q03                                                  |        588 |           0.75 |    2.12 |     1.60 |     0 |    1.00 |    2.00 |    4.00 |      5 |
| MDI\_q04                                                  |        589 |           0.75 |    1.47 |     1.52 |     0 |    0.00 |    1.00 |    3.00 |      5 |
| MDI\_q05                                                  |        594 |           0.75 |    0.96 |     1.34 |     0 |    0.00 |    0.00 |    1.00 |      5 |
| MDI\_q06                                                  |        593 |           0.75 |    1.10 |     1.45 |     0 |    0.00 |    1.00 |    1.00 |      5 |
| MDI\_q07                                                  |        589 |           0.75 |    1.99 |     1.56 |     0 |    1.00 |    1.00 |    3.00 |      5 |
| MDI\_q08a                                                 |        598 |           0.75 |    1.52 |     1.56 |     0 |    0.00 |    1.00 |    3.00 |      5 |
| MDI\_q08b                                                 |        607 |           0.74 |    1.59 |     1.52 |     0 |    0.00 |    1.00 |    3.00 |      5 |
| MDI\_q09                                                  |        590 |           0.75 |    2.29 |     1.81 |     0 |    1.00 |    2.00 |    4.00 |      5 |
| MDI\_q10a                                                 |        586 |           0.75 |    0.61 |     1.13 |     0 |    0.00 |    0.00 |    1.00 |      5 |
| MDI\_q10b                                                 |        589 |           0.75 |    0.58 |     1.07 |     0 |    0.00 |    0.00 |    1.00 |      5 |
| MDI\_score                                                |        631 |           0.73 |   16.30 |    11.80 |     0 |    7.00 |   13.00 |   24.50 |     50 |
| MINITQ\_lvs                                               |       1707 |           0.27 |    1.00 |     0.04 |     0 |    1.00 |    1.00 |    1.00 |      1 |
| MINITQ\_q01                                               |       1710 |           0.27 |    1.52 |     0.64 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| MINITQ\_q02                                               |       1710 |           0.27 |    0.80 |     0.79 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| MINITQ\_q03                                               |       1711 |           0.27 |    0.71 |     0.68 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| MINITQ\_q04                                               |       1710 |           0.27 |    0.86 |     0.67 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| MINITQ\_q05                                               |       1711 |           0.27 |    0.82 |     0.79 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| MINITQ\_q06                                               |       1710 |           0.27 |    1.48 |     0.61 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| MINITQ\_q07                                               |       1711 |           0.27 |    1.58 |     0.61 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| MINITQ\_q08                                               |       1712 |           0.27 |    1.31 |     0.76 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| MINITQ\_q09                                               |       1711 |           0.27 |    1.17 |     0.73 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| MINITQ\_q10                                               |       1709 |           0.27 |    1.41 |     0.70 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| MINITQ\_q11                                               |       1712 |           0.27 |    0.94 |     0.81 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| MINITQ\_q12                                               |       1709 |           0.27 |    1.28 |     0.68 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| MINITQ\_score                                             |       1725 |           0.27 |   13.86 |     5.52 |     0 |   10.00 |   14.00 |   18.00 |     24 |
| TBF12\_lvs                                                |       1394 |           0.41 |    0.99 |     0.08 |     0 |    1.00 |    1.00 |    1.00 |      1 |
| TBF12\_q01                                                |       1399 |           0.40 |    1.16 |     0.64 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TBF12\_q02                                                |       1401 |           0.40 |    0.99 |     0.74 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TBF12\_q03                                                |       1398 |           0.41 |    1.34 |     0.60 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TBF12\_q04                                                |       1405 |           0.40 |    1.47 |     0.60 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| TBF12\_q05                                                |       1403 |           0.40 |    1.06 |     0.75 |     0 |    0.50 |    1.00 |    2.00 |      2 |
| TBF12\_q06                                                |       1398 |           0.41 |    1.15 |     0.66 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TBF12\_q07                                                |       1403 |           0.40 |    1.01 |     0.75 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TBF12\_q08                                                |       1400 |           0.40 |    0.91 |     0.77 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TBF12\_q09                                                |       1399 |           0.40 |    0.77 |     0.73 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TBF12\_q10                                                |       1400 |           0.40 |    1.05 |     0.63 |     0 |    1.00 |    1.00 |    1.00 |      2 |
| TBF12\_q11                                                |       1397 |           0.41 |    0.89 |     0.74 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TBF12\_q12                                                |       1401 |           0.40 |    1.19 |     0.68 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TBF12\_score                                              |       1430 |           0.39 |   13.01 |     5.44 |     0 |    9.00 |   13.00 |   17.00 |     24 |
| TFI\_lvs                                                  |        924 |           0.61 |    0.98 |     0.14 |   \-1 |    1.00 |    1.00 |    1.00 |      1 |
| TFI\_q01                                                  |        975 |           0.59 |   68.84 |    26.08 |     0 |   50.00 |   70.00 |   90.00 |    100 |
| TFI\_q02                                                  |        966 |           0.59 |    6.76 |     2.03 |     0 |    5.00 |    7.00 |    8.00 |     10 |
| TFI\_q03                                                  |       1018 |           0.57 |   59.29 |    27.71 |  \-10 |   40.00 |   60.00 |   80.00 |    100 |
| TFI\_q04                                                  |        973 |           0.59 |    6.76 |     2.93 |     0 |    5.00 |    7.00 |   10.00 |     10 |
| TFI\_q05                                                  |        971 |           0.59 |    5.92 |     2.45 |     0 |    4.00 |    6.00 |    8.00 |     10 |
| TFI\_q06                                                  |        965 |           0.59 |    6.37 |     2.69 |     0 |    5.00 |    7.00 |    8.00 |     10 |
| TFI\_q07                                                  |        953 |           0.59 |    5.48 |     2.70 |     0 |    3.00 |    6.00 |    8.00 |     10 |
| TFI\_q08                                                  |        953 |           0.59 |    4.60 |     2.88 |     0 |    2.00 |    5.00 |    7.00 |     10 |
| TFI\_q09                                                  |        955 |           0.59 |    4.86 |     2.62 |     0 |    3.00 |    5.00 |    7.00 |     10 |
| TFI\_q10                                                  |        954 |           0.59 |    5.48 |     3.37 |     0 |    2.00 |    6.00 |    8.00 |     10 |
| TFI\_q11                                                  |        958 |           0.59 |    4.96 |     3.38 |     0 |    2.00 |    5.00 |    8.00 |     10 |
| TFI\_q12                                                  |        980 |           0.58 |    5.10 |     3.49 |     0 |    2.00 |    5.00 |    8.00 |     10 |
| TFI\_q13                                                  |        950 |           0.60 |    4.79 |     3.06 |     0 |    2.00 |    5.00 |    7.00 |     10 |
| TFI\_q14                                                  |        947 |           0.60 |    4.84 |     3.17 |     0 |    2.00 |    5.00 |    8.00 |     10 |
| TFI\_q15                                                  |        950 |           0.60 |    5.24 |     3.28 |     0 |    2.00 |    5.00 |    8.00 |     10 |
| TFI\_q16                                                  |        951 |           0.60 |    5.48 |     2.77 |     0 |    3.00 |    6.00 |    8.00 |     10 |
| TFI\_q17                                                  |        951 |           0.60 |    5.95 |     2.73 |     0 |    4.00 |    6.00 |    8.00 |     10 |
| TFI\_q18                                                  |        948 |           0.60 |    6.77 |     2.74 |     0 |    5.00 |    8.00 |    9.00 |     10 |
| TFI\_q19                                                  |        964 |           0.59 |    4.64 |     2.94 |     0 |    2.00 |    5.00 |    7.00 |     10 |
| TFI\_q20                                                  |        956 |           0.59 |    5.17 |     2.90 |     0 |    3.00 |    5.00 |    8.00 |     10 |
| TFI\_q21                                                  |        960 |           0.59 |    4.33 |     2.94 |     0 |    2.00 |    4.00 |    7.00 |     10 |
| TFI\_q22                                                  |        964 |           0.59 |    4.18 |     3.06 |     0 |    2.00 |    4.00 |    7.00 |     10 |
| TFI\_q23                                                  |        950 |           0.60 |    5.40 |     3.00 |     0 |    3.00 |    5.00 |    8.00 |     10 |
| TFI\_q24                                                  |        951 |           0.60 |    4.78 |     2.99 |     0 |    2.00 |    5.00 |    7.00 |     10 |
| TFI\_q25                                                  |        952 |           0.59 |    5.04 |     3.16 |     0 |    2.00 |    5.00 |    8.00 |     10 |
| TFI\_score                                                |        956 |           0.59 |   54.33 |    20.93 |     1 |   39.00 |   55.00 |   70.00 |    100 |
| TFI\_intrusive                                            |        962 |           0.59 |   65.22 |    22.13 |     0 |   50.00 |   70.00 |   83.33 |    100 |
| TFI\_sense\_of\_control                                   |        961 |           0.59 |   63.36 |    23.52 |     0 |   46.67 |   66.67 |   83.33 |    100 |
| TFI\_cognitive                                            |        952 |           0.59 |   49.79 |    25.15 |     0 |   30.00 |   50.00 |   70.00 |    100 |
| TFI\_sleep                                                |        959 |           0.59 |   51.83 |    32.76 |     0 |   20.00 |   53.33 |   80.00 |    100 |
| TFI\_auditory                                             |        948 |           0.60 |   49.59 |    30.46 |     0 |   23.33 |   50.00 |   76.67 |    100 |
| TFI\_relaxation                                           |        950 |           0.60 |   60.68 |    25.82 |     0 |   43.33 |   63.33 |   80.00 |    100 |
| TFI\_quality\_of\_life                                    |        958 |           0.59 |   45.84 |    26.98 |     0 |   25.00 |   45.00 |   70.00 |    100 |
| TFI\_emotional                                            |        951 |           0.60 |   50.71 |    28.47 |     0 |   26.67 |   50.00 |   73.33 |    100 |
| THI\_lvs                                                  |        280 |           0.88 |    0.98 |     0.15 |     0 |    1.00 |    1.00 |    1.00 |      1 |
| THI\_q01                                                  |        331 |           0.86 |    2.51 |     1.31 |     0 |    2.00 |    2.00 |    4.00 |      4 |
| THI\_q02                                                  |        334 |           0.86 |    2.02 |     1.58 |     0 |    0.00 |    2.00 |    4.00 |      4 |
| THI\_q03                                                  |        342 |           0.85 |    1.82 |     1.42 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q04                                                  |        346 |           0.85 |    1.01 |     1.34 |     0 |    0.00 |    0.00 |    2.00 |      4 |
| THI\_q05                                                  |        345 |           0.85 |    1.86 |     1.44 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q06                                                  |        343 |           0.85 |    1.77 |     1.49 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q07                                                  |        340 |           0.86 |    2.32 |     1.57 |     0 |    2.00 |    2.00 |    4.00 |      4 |
| THI\_q08                                                  |        344 |           0.85 |    2.97 |     1.35 |     0 |    2.00 |    4.00 |    4.00 |      4 |
| THI\_q09                                                  |        335 |           0.86 |    2.09 |     1.60 |     0 |    0.00 |    2.00 |    4.00 |      4 |
| THI\_q10                                                  |        337 |           0.86 |    2.23 |     1.41 |     0 |    2.00 |    2.00 |    4.00 |      4 |
| THI\_q11                                                  |        337 |           0.86 |    1.18 |     1.52 |     0 |    0.00 |    0.00 |    2.00 |      4 |
| THI\_q12                                                  |        331 |           0.86 |    2.46 |     1.39 |     0 |    2.00 |    2.00 |    4.00 |      4 |
| THI\_q13                                                  |        340 |           0.86 |    1.62 |     1.51 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q14                                                  |        337 |           0.86 |    2.03 |     1.52 |     0 |    0.00 |    2.00 |    4.00 |      4 |
| THI\_q15                                                  |        331 |           0.86 |    1.81 |     1.63 |     0 |    0.00 |    2.00 |    4.00 |      4 |
| THI\_q16                                                  |        346 |           0.85 |    1.25 |     1.34 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q17                                                  |        331 |           0.86 |    1.59 |     1.56 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q18                                                  |        335 |           0.86 |    1.95 |     1.36 |     0 |    2.00 |    2.00 |    2.00 |      4 |
| THI\_q19                                                  |        335 |           0.86 |    3.24 |     1.29 |     0 |    2.00 |    4.00 |    4.00 |      4 |
| THI\_q20                                                  |        343 |           0.85 |    1.65 |     1.60 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q21                                                  |        352 |           0.85 |    2.11 |     1.43 |     0 |    2.00 |    2.00 |    4.00 |      4 |
| THI\_q22                                                  |        336 |           0.86 |    1.59 |     1.54 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q23                                                  |        338 |           0.86 |    1.59 |     1.44 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_q24                                                  |        340 |           0.86 |    2.89 |     1.53 |     0 |    2.00 |    4.00 |    4.00 |      4 |
| THI\_q25                                                  |        334 |           0.86 |    1.72 |     1.56 |     0 |    0.00 |    2.00 |    2.00 |      4 |
| THI\_score                                                |        338 |           0.86 |   49.31 |    22.99 |     0 |   32.00 |   48.00 |   66.00 |    100 |
| TQ\_lvs                                                   |        842 |           0.64 |    0.98 |     0.13 |     0 |    1.00 |    1.00 |    1.00 |      1 |
| TQ\_q01                                                   |        849 |           0.64 |    0.84 |     0.69 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q02                                                   |        849 |           0.64 |    0.69 |     0.70 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q03                                                   |        861 |           0.63 |    1.05 |     0.82 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q04                                                   |        853 |           0.64 |    0.76 |     0.80 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q05                                                   |        850 |           0.64 |    1.37 |     0.71 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| TQ\_q06                                                   |        919 |           0.61 |    1.10 |     0.74 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q07                                                   |        848 |           0.64 |    1.45 |     0.67 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| TQ\_q08                                                   |        851 |           0.64 |    0.60 |     0.72 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q09                                                   |        854 |           0.64 |    0.95 |     0.76 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q10                                                   |        847 |           0.64 |    1.60 |     0.58 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| TQ\_q11                                                   |        849 |           0.64 |    1.42 |     0.67 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| TQ\_q12                                                   |        855 |           0.64 |    0.77 |     0.80 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q13                                                   |        853 |           0.64 |    1.03 |     0.76 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q14                                                   |        856 |           0.64 |    1.20 |     0.84 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q15                                                   |        849 |           0.64 |    1.31 |     0.73 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q16                                                   |        851 |           0.64 |    0.71 |     0.78 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q17                                                   |        859 |           0.63 |    0.67 |     0.72 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q18                                                   |        852 |           0.64 |    0.77 |     0.78 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q19                                                   |        855 |           0.64 |    1.15 |     0.81 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q20                                                   |        850 |           0.64 |    0.88 |     0.66 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q21                                                   |        860 |           0.63 |    1.22 |     0.73 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q22                                                   |        848 |           0.64 |    0.71 |     0.80 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q23                                                   |        855 |           0.64 |    1.13 |     0.81 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q24                                                   |        845 |           0.64 |    0.82 |     0.75 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q25                                                   |        869 |           0.63 |    0.84 |     0.83 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q26                                                   |        856 |           0.64 |    0.43 |     0.68 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q27                                                   |        851 |           0.64 |    1.17 |     0.78 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q28                                                   |        848 |           0.64 |    0.78 |     0.81 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q29                                                   |        854 |           0.64 |    1.34 |     0.79 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| TQ\_q30                                                   |        862 |           0.63 |    0.50 |     0.69 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q31                                                   |        851 |           0.64 |    0.78 |     0.81 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q32                                                   |        871 |           0.63 |    0.41 |     0.61 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q33                                                   |        852 |           0.64 |    0.99 |     0.78 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q34                                                   |        849 |           0.64 |    1.45 |     0.65 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| TQ\_q35                                                   |        850 |           0.64 |    1.52 |     0.64 |     0 |    1.00 |    2.00 |    2.00 |      2 |
| TQ\_q36                                                   |        848 |           0.64 |    1.15 |     0.79 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q37                                                   |        849 |           0.64 |    1.03 |     0.80 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q38                                                   |        854 |           0.64 |    0.80 |     0.81 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q39                                                   |        850 |           0.64 |    1.05 |     0.76 |     0 |    0.00 |    1.00 |    2.00 |      2 |
| TQ\_q40                                                   |        849 |           0.64 |    1.27 |     0.69 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q41                                                   |        861 |           0.63 |    0.57 |     0.71 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q42                                                   |        851 |           0.64 |    0.39 |     0.68 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q43                                                   |        850 |           0.64 |    1.29 |     0.73 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q44                                                   |        854 |           0.64 |    0.81 |     0.71 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q45                                                   |        853 |           0.64 |    1.30 |     0.77 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q46                                                   |        871 |           0.63 |    0.56 |     0.70 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q47                                                   |        860 |           0.63 |    0.85 |     0.79 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TQ\_q48                                                   |        847 |           0.64 |    1.20 |     0.71 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q49                                                   |        855 |           0.64 |    1.15 |     0.79 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TQ\_q50                                                   |        845 |           0.64 |    0.58 |     0.65 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q51                                                   |        853 |           0.64 |    0.47 |     0.71 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_q52                                                   |        852 |           0.64 |    0.51 |     0.74 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TQ\_score                                                 |        854 |           0.64 |   41.18 |    17.67 |     2 |   28.00 |   40.00 |   54.00 |     82 |
| TQ\_emotional\_distress                                   |        854 |           0.64 |   11.14 |     5.81 |     0 |    6.75 |   11.00 |   16.00 |     24 |
| TQ\_cognitive\_distress                                   |        854 |           0.64 |    8.04 |     4.33 |     0 |    5.00 |    8.00 |   12.00 |     16 |
| TQ\_intrusiveness                                         |        854 |           0.64 |   10.77 |     3.57 |     0 |    8.00 |   11.00 |   14.00 |     16 |
| TQ\_auditory\_perceptual\_difficulties                    |        854 |           0.64 |    5.63 |     3.89 |     0 |    2.00 |    5.00 |    9.00 |     14 |
| TQ\_sleep\_disturbances                                   |        854 |           0.64 |    3.45 |     2.68 |     0 |    1.00 |    3.00 |    6.00 |      8 |
| TQ\_somatic\_complaints                                   |        854 |           0.64 |    2.00 |     1.92 |     0 |    0.00 |    2.00 |    3.00 |      6 |
| TSCHQ\_lvs                                                |        979 |           0.58 |    0.89 |     0.31 |     0 |    1.00 |    1.00 |    1.00 |      1 |
| TSCHQ\_months\_between\_begin\_tinnitus\_and\_visit\_time |       1748 |           0.26 |   76.38 |   100.32 |   \-7 |   13.00 |   27.00 |  105.00 |    586 |
| TSCHQ\_months\_since\_begin\_tinnitus                     |       1748 |           0.26 |  109.87 |   101.60 |     3 |   47.00 |   68.00 |  141.00 |    640 |
| TSCHQ\_q01\_age                                           |          0 |           1.00 |   54.30 |    12.24 |    19 |   47.00 |   56.00 |   62.00 |     91 |
| TSCHQ\_q02\_sex                                           |          0 |           1.00 |    0.32 |     0.47 |     0 |    0.00 |    0.00 |    1.00 |      1 |
| TSCHQ\_q03\_handedness                                    |        990 |           0.58 |    0.27 |     0.63 |     0 |    0.00 |    0.00 |    0.00 |      2 |
| TSCHQ\_q04\_family                                        |       1005 |           0.57 |    0.75 |     0.43 |     0 |    1.00 |    1.00 |    1.00 |      1 |
| TSCHQ\_q05\_1\_begin\_tinnitus\_additional                |       1153 |           0.51 |    1.15 |     0.79 |     0 |    1.00 |    1.00 |    2.00 |      2 |
| TSCHQ\_q06\_begin\_perception                             |       1059 |           0.55 |    0.53 |     0.50 |     0 |    0.00 |    1.00 |    1.00 |      1 |
| TSCHQ\_q08\_pulsating                                     |       1006 |           0.57 |    1.70 |     0.65 |     0 |    2.00 |    2.00 |    2.00 |      3 |
| TSCHQ\_q09\_perception                                    |        987 |           0.58 |    2.56 |     1.55 |     0 |    1.00 |    2.00 |    4.00 |      7 |
| TSCHQ\_q10\_history                                       |        995 |           0.58 |    0.85 |     0.36 |     0 |    1.00 |    1.00 |    1.00 |      2 |
| TSCHQ\_q11\_daily\_volume                                 |       1001 |           0.57 |    0.35 |     0.48 |     0 |    0.00 |    0.00 |    1.00 |      1 |
| TSCHQ\_q12\_personal\_volume                              |       1015 |           0.57 |   76.68 |   107.12 |     0 |   50.00 |   70.00 |   80.00 |    999 |
| TSCHQ\_q14\_tone\_type                                    |       1004 |           0.57 |    0.71 |     1.06 |     0 |    0.00 |    0.00 |    1.00 |      4 |
| TSCHQ\_q15\_tone\_frequency                               |       1050 |           0.55 |    0.94 |     0.75 |     0 |    0.00 |    1.00 |    1.00 |      4 |
| TSCHQ\_q16\_awareness                                     |        997 |           0.58 |   81.68 |    97.82 |     0 |   50.00 |   80.00 |  100.00 |    999 |
| TSCHQ\_q17\_angerness                                     |        995 |           0.58 |   66.37 |    90.03 | \-160 |   30.00 |   60.00 |   90.00 |    999 |
| TSCHQ\_q18\_treatment\_count                              |       1010 |           0.57 |    1.83 |     1.03 |     0 |    1.00 |    2.00 |    3.00 |      6 |
| TSCHQ\_q19\_context\_volume                               |        996 |           0.58 |    0.49 |     0.73 |     0 |    0.00 |    0.00 |    1.00 |      3 |
| TSCHQ\_q20\_context\_change                               |        993 |           0.58 |    0.64 |     0.79 |     0 |    0.00 |    0.00 |    1.00 |      3 |
| TSCHQ\_q21\_head\_change                                  |        997 |           0.58 |    0.58 |     0.49 |     0 |    0.00 |    1.00 |    1.00 |      1 |
| TSCHQ\_q22\_nap\_change                                   |       1064 |           0.55 |    1.54 |     0.80 |     0 |    1.00 |    2.00 |    2.00 |      3 |
| TSCHQ\_q23\_sleep\_correlation                            |       1009 |           0.57 |    1.19 |     0.80 |     0 |    1.00 |    1.00 |    2.00 |      3 |
| TSCHQ\_q24\_stress\_correlation                           |       1022 |           0.57 |    0.50 |     0.87 |     0 |    0.00 |    0.00 |    1.00 |      3 |
| TSCHQ\_q26\_hear\_problems                                |       1004 |           0.57 |    0.42 |     0.50 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TSCHQ\_q27\_hear\_helps                                   |        998 |           0.58 |    2.73 |     0.63 |     0 |    3.00 |    3.00 |    3.00 |      4 |
| TSCHQ\_q28\_noise\_sensitive                              |        992 |           0.58 |    2.29 |     1.21 |     0 |    2.00 |    2.00 |    3.00 |      5 |
| TSCHQ\_q29\_noise\_dependent                              |        993 |           0.58 |    0.57 |     0.69 |     0 |    0.00 |    0.00 |    1.00 |      3 |
| TSCHQ\_q30\_headache                                      |        996 |           0.58 |    0.62 |     0.49 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TSCHQ\_q31\_bogus                                         |       1014 |           0.57 |    0.68 |     0.48 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TSCHQ\_q32\_jaw\_problems                                 |       1002 |           0.57 |    0.70 |     0.46 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TSCHQ\_q33\_nape\_problems                                |       1001 |           0.57 |    0.40 |     0.49 |     0 |    0.00 |    0.00 |    1.00 |      2 |
| TSCHQ\_q34\_other\_problems                               |       1003 |           0.57 |    0.55 |     0.50 |     0 |    0.00 |    1.00 |    1.00 |      2 |
| TSCHQ\_q35\_psychological\_treatment                      |        992 |           0.58 |    0.75 |     0.43 |     0 |    1.00 |    1.00 |    1.00 |      2 |
| TSCHQ\_q36\_otologic                                      |       2168 |           0.08 |    1.66 |     0.48 |     1 |    1.00 |    2.00 |    2.00 |      2 |
| TSQ\_lvs                                                  |         96 |           0.96 |    1.00 |     0.07 |     0 |    1.00 |    1.00 |    1.00 |      1 |
| TSQ\_q1                                                   |        125 |           0.95 |    2.39 |     0.90 |     0 |    2.00 |    2.00 |    3.00 |      4 |
| TSQ\_q2                                                   |        111 |           0.95 |    6.40 |     2.22 |     0 |    5.00 |    7.00 |    8.00 |     10 |
| TSQ\_q3                                                   |        111 |           0.95 |    6.91 |     2.34 |     0 |    5.00 |    7.00 |    9.00 |     10 |
| TSQ\_q4                                                   |        116 |           0.95 |    6.61 |     2.44 |     0 |    5.00 |    7.00 |    8.00 |     10 |
| TSQ\_q5                                                   |        111 |           0.95 |    6.78 |     2.69 |     0 |    5.00 |    7.00 |    9.00 |     10 |
| TSQ\_q6                                                   |        109 |           0.95 |    6.63 |     2.42 |     0 |    5.00 |    7.00 |    8.00 |     10 |
| WHOQOL\_domain01                                          |       1031 |           0.56 |   12.49 |     1.85 |     5 |   11.00 |   13.00 |   14.00 |     18 |
| WHOQOL\_domain02                                          |       1031 |           0.56 |   13.61 |     2.09 |     6 |   12.00 |   14.00 |   15.00 |     18 |
| WHOQOL\_domain03                                          |       1038 |           0.56 |   14.60 |     3.27 |     4 |   12.00 |   15.00 |   17.00 |     20 |
| WHOQOL\_domain04                                          |       1027 |           0.56 |   16.51 |     2.23 |     6 |   15.00 |   17.00 |   18.00 |     20 |
| WHOQOL\_lvs                                               |       1013 |           0.57 |    0.99 |     0.12 |     0 |    1.00 |    1.00 |    1.00 |      1 |
| WHOQOL\_more\_20pct\_missing                              |       1013 |           0.57 |    0.01 |     0.12 |     0 |    0.00 |    0.00 |    0.00 |      1 |
| WHOQOL\_q01                                               |       1022 |           0.57 |    3.23 |     0.96 |     1 |    3.00 |    3.00 |    4.00 |      5 |
| WHOQOL\_q02                                               |       1019 |           0.57 |    2.87 |     1.07 |     1 |    2.00 |    3.00 |    4.00 |      5 |
| WHOQOL\_q03                                               |       1022 |           0.57 |    3.85 |     1.13 |     1 |    3.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q04                                               |       1038 |           0.56 |    3.87 |     1.18 |     1 |    3.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q05                                               |       1018 |           0.57 |    3.21 |     0.94 |     1 |    3.00 |    3.00 |    4.00 |      5 |
| WHOQOL\_q06                                               |       1035 |           0.56 |    3.75 |     1.10 |     1 |    3.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q07                                               |       1018 |           0.57 |    3.17 |     0.90 |     1 |    3.00 |    3.00 |    4.00 |      5 |
| WHOQOL\_q08                                               |       1022 |           0.57 |    3.59 |     0.89 |     1 |    3.00 |    4.00 |    4.00 |      5 |
| WHOQOL\_q09                                               |       1035 |           0.56 |    4.02 |     0.79 |     1 |    4.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q10                                               |       1024 |           0.56 |    3.50 |     0.95 |     1 |    3.00 |    4.00 |    4.00 |      5 |
| WHOQOL\_q11                                               |       1032 |           0.56 |    4.07 |     0.86 |     1 |    4.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q12                                               |       1023 |           0.56 |    4.09 |     0.91 |     1 |    4.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q13                                               |       1035 |           0.56 |    4.52 |     0.65 |     1 |    4.00 |    5.00 |    5.00 |      5 |
| WHOQOL\_q14                                               |       1024 |           0.56 |    4.01 |     0.98 |     1 |    3.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q15                                               |       1038 |           0.56 |    4.21 |     0.87 |     1 |    4.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q16                                               |       1023 |           0.56 |    2.87 |     1.22 |     1 |    2.00 |    3.00 |    4.00 |      5 |
| WHOQOL\_q17                                               |       1030 |           0.56 |    3.64 |     1.02 |     1 |    3.00 |    4.00 |    4.00 |      5 |
| WHOQOL\_q18                                               |       1031 |           0.56 |    3.33 |     1.17 |     1 |    2.00 |    4.00 |    4.00 |      5 |
| WHOQOL\_q19                                               |       1035 |           0.56 |    3.43 |     1.00 |     1 |    3.00 |    4.00 |    4.00 |      5 |
| WHOQOL\_q20                                               |       1035 |           0.56 |    3.82 |     0.99 |     1 |    3.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q21                                               |       1071 |           0.54 |    3.39 |     1.11 |     1 |    3.00 |    4.00 |    4.00 |      5 |
| WHOQOL\_q22                                               |       1034 |           0.56 |    3.73 |     0.90 |     1 |    3.00 |    4.00 |    4.00 |      5 |
| WHOQOL\_q23                                               |       1024 |           0.56 |    4.20 |     0.89 |     1 |    4.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q24                                               |       1043 |           0.56 |    3.86 |     0.90 |     1 |    3.00 |    4.00 |    4.00 |      5 |
| WHOQOL\_q25                                               |       1048 |           0.55 |    4.26 |     0.83 |     1 |    4.00 |    4.00 |    5.00 |      5 |
| WHOQOL\_q26                                               |       1030 |           0.56 |    3.21 |     1.04 |     1 |    2.00 |    3.00 |    4.00 |      5 |
