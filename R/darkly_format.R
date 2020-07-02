#' Format helper function for labels
#' @param x  input vector frame requires input
#' @param labelx label identifier, takes "round" or "percent', all others default to character
#' @param n.decimals when labelx=round digits parameter for round(), when labelx=percent accuracy parameter for scales::percent()
#' @export
#'
darkly_format = function(x, labelx, n.decimals = 2) {
  case_when(
    labelx == "round" ~ as.character(round(x, n.decimals)),
    labelx == "percent" ~ scales::percent(x, n.decimals),
    T ~ as.character(x)
  )
}
