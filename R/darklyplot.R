#' Function to create a dark themed plot
#'
#' A dark themed plot
#' @param df input data frame requires input, must have a date column named date
#' @param column input data column name to plot
#' @param col color for line, defaults to "white"
#' @param n.decimals number of decimals to display, default is 0
#' @param refline include a reference line? default is FALSE
#' @param refValue value for reference line, defaults to 0
#' @param shade shade under the line? default is FALSE
#' @param shadeCol color for shading under line default is "dodgerblue"
#' @param shadeAlpha alpha (transparency) for shading, default is 0.15
#' @param minCol color for minimum value
#' @param maxCol color for maximum value
#' @param firstCol color for first value
#' @param lastCol color of last value
#' @param labelX function for labeling values, default is round, percent also available
#' @param Ndodge n.dodge parameter passed to scale_x_date(guide_axis(n.dodge = Ndodge)...)
#' @keywords theme
#' @export
#' @examples
#' darklyplot(mtg_rate,"rate",labelx="roundx",n.decimals=3)
#' darklyplot(mtg_rate,"rate",labelx="roundx",n.decimals=3,shade=TRUE,refline=TRUE)
#' @import mdthemes
#' @import ggthemes



darklyplot <- function(df,
                       column,
                       col="white",
                       n.decimals=0,
                       refline=FALSE,
                       refValue=0,
                       refCol=NA,
                       shade=FALSE,
                       shadeCol="dodgerblue",
                       shadeAlpha=0.15,
                       minCol="#6CB23F",
                       maxCol="#FD5305",
                       firstCol="white",
                       lastCol="#00AFEF",
                       labelx="round",
                       Ndodge=3){

  if (is.na(refCol)){refCol=col}
  column=sym(column)
  df <- mutate(df, yvar=!!column)
  dd <- max(df$date)
  dd2 <- last(df[df$yvar==min(df$yvar),]$date)
  dd3 <- last(df[df$yvar==max(df$yvar),]$date)
  g1 <-
    ggplot(data = df, aes(x = date, y = !!column)) +
    geom_line(color = col, size = 1.05) +
    geom_point(
      data = . %>% filter(date == min(date)),
      color = firstCol,
      size = 6,
      alpha = 0.5
    ) +
    geom_point(
      data = . %>% filter(date == dd2),
      color = minCol,
      size = 6,
      alpha = 0.5
    ) +
    geom_point(
      data = . %>% filter(date == dd3),
      color = maxCol,
      size = 6,
      alpha = 0.5
    ) +
    geom_point(
      data = . %>% filter(date == max(date)),
      color = lastCol,
      size = 6,
      alpha = 0.5
    ) +
    if (refline) {
      geom_segment(
        y = refValue,
        yend = refValue,
        x = min(df$date),
        xend = dd,
        linetype = 2,
        color = refCol
      )
    }
  g1 <-
    g1 +
    ggthemes::geom_rangeframe(color = col) +
    scale_y_continuous(
      breaks = c(
        if (refline) {
          refValue
        },
        max(df$yvar),
        last(df$yvar),
        first(df$yvar),
        min(df$yvar)
      ),
      limits = c(min(
        ifelse(refline, refValue, min(df$yvar)), min(pretty(df$yvar))
      ),
      max(
        ifelse(refline, refValue, max(df$yvar)), max(pretty(df$yvar))
      )),
      guide = guide_axis(n.dodge = 1),
      labels = c(
        if (refline) {
          glue::glue(
            "{shiny::span('",
            darkly_format(refValue, labelx, n.decimals),
            "', style='color:",
            refCol,
            "')}"
          )
        },
        glue::glue(
          "{shiny::span('**",
          darkly_format(max(df$yvar), labelx, n.decimals),
          "**', style='color:",
          maxCol,
          "')}"
        ),
        glue::glue(
          "{shiny::span('**",
          darkly_format(tail(df, 1)$yvar, labelx, n.decimals),
          "**', style='color:",
          lastCol,
          "')}"
        ),
        glue::glue(
          "{shiny::span('**",
          darkly_format(head(df, 1)$yvar, labelx, n.decimals),
          "**', style='color:",
          firstCol,
          "')}"
        ),
        glue::glue(
          "{shiny::span('**",
          darkly_format(min(df$yvar), labelx, n.decimals),
          "**', style='color:",
          minCol,
          "')}"
        )
      )
    ) +
    scale_x_date(
      breaks = c(min(df$date), dd3, dd2, max(df$date)),
      guide = guide_axis(n.dodge = Ndodge),
      labels =
        c(
          #as.character(min(df$date)),
          glue::glue(
            "{shiny::span('**",
            as.character(min(df$date)),
            "**', style='color:",
            firstCol,
            "')}"
          ),
          glue::glue(
            "{shiny::span('**",
            as.character(dd3),
            "**', style='color:",
            maxCol,
            "')}"
          ),
          glue::glue(
            "{shiny::span('**",
            as.character(dd2),
            "**', style='color:",
            minCol,
            "')}"
          ),
          glue::glue(
            "{shiny::span('**",
            as.character(max(df$date)),
            "**', style='color:",
            lastCol,
            "')}"
          )
        )
      # as.character(max(df$date)))
    ) +
    labs(
      subtitle = glue::glue(
        "{shiny::span('**First** ',style='color:",
        firstCol,
        "')}",
        " ",
        "{shiny::span('**Max**',style='color:",
        maxCol,
        "')}",
        " ",
        "{shiny::span('**Min**',style='color:",
        minCol,
        "')}",
        " ",
        "{shiny::span('**Last**',style='color:",
        lastCol,
        "')}"
      )
    ) +
    as_md_theme(
      theme_dark2(base_size = 18) +
        theme(
          axis.ticks.length = unit(0.5, "cm"),
          axis.ticks = element_line(color = col, size  =  0.2),
          plot.title = element_text(face = "bold"),
          panel.grid.minor = element_blank(),
          plot.subtitle = element_text(size = rel(0.8)),
          panel.grid.major = element_blank()
        )
    )

  g1 + if (shade) {
    geom_ribbon(
      ymin = refValue,
      aes(ymax = yvar),
      alpha = shadeAlpha,
      fill = shadeCol,
      color = NA
    )
  }

}
