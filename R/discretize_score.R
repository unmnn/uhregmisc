#' Discretize scores
#'
#' `discretize_score` disretizes a numeric questionnaire score according to
#' predefined cutoff values from literature.
#'
#' @param x A numeric vector.
#' @param name The name of the score. One of `c("MINITQ_score", "TBF12_score", "THI_score", "TQ_score")`.
#'
#' @return A factor.
#' @export
#'
#' @examples
#' x <- uhreg$MINITQ_score
#' discretize_score(x, "MINITQ_score")
#'
discretize_score <- function(x, name) {

  if(name == "MINITQ_score") {
    factor(
      cut(x, breaks = c(-Inf, 7, 12, 18, Inf),
          labels = c("compensated [1-7]",
                     "moderately affected [8-12]",
                     "severely affected [13-18]",
                     "extremely affected [19-24]")
      )
    )
  }

  if(name == "TBF12_score") {
    factor(
      cut(x, breaks = c(-Inf, 13, 20, Inf),
          labels = c("slight [0-13]",
                     "moderate [14-20]",
                     "severe [21-24]")
      )
    )
  }

  if(name == "THI_score") {
    factor(
      cut(x, breaks = c(-Inf, 16, 36, 56, 76, Inf),
          labels = c("slight [0-16]",
                     "mild [18-36]",
                     "moderate [38-56]",
                     "severe [58-76]",
                     "catastrophic [78-100]")
      )
    )
  }

  if(name == "TQ_score") {
    factor(
      cut(x, breaks = c(-Inf, 30, 46, 59, Inf),
          labels = c("slight [0-30]",
                     "moderate [31-46]",
                     "severe [47-59]",
                     "very severe [60-84]")
      )
    )
  }

  x
}
