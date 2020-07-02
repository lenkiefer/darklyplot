#' Theme Dark Function
#'
#' A dark themed function
#' @param base_size  defaults to 12
#' @param base_family defaults to Courier New
#' @keywords theme
#' @export
#' @examples
#' ggplot(data=NULL,aes(x=1:2,y=1:2))+geom_point()+theme_dark2()
#'
theme_dark2 = function(base_size = 12, base_family = "Courier New") {
  theme_grey(base_size = base_size, base_family = base_family) %+replace%

    theme(
      line=element_line(color="white"),
      rect=element_rect(color="white"),
      text=element_text(color="white"),
      # Specify axis options
      axis.line = element_blank(),
      axis.text.x = element_text(size = base_size*0.8, color = "white", lineheight = 0.9),
      axis.text.y = element_text(size = base_size*0.8, color = "white", lineheight = 0.9),
      axis.ticks = element_line(color = "white", size  =  0.2),
      axis.title.x = element_text(size = base_size, color = "white", margin = margin(0, 10, 0, 0)),
      axis.title.y = element_text(size = base_size, color = "white", angle = 90, margin = margin(0, 10, 0, 0)),
      axis.ticks.length = unit(0.3, "lines"),
      # Specify legend options
      legend.background = element_rect(color = NA, fill = " gray10"),
      legend.key = element_rect(color = "white",  fill = " gray10"),
      legend.key.size = unit(1.2, "lines"),
      legend.key.height = NULL,
      legend.key.width = NULL,
      legend.text = element_text(size = base_size*0.8, color = "white"),
      legend.title = element_text(size = base_size*0.8, face = "bold", hjust = 0, color = "white"),
      legend.position = "right",
      legend.text.align = NULL,
      legend.title.align = NULL,
      legend.direction = "vertical",
      legend.box = NULL,
      # Specify panel options
      panel.background = element_rect(fill = " gray10", color  =  NA),
      #panel.border = element_rect(fill = NA, color = "white"),
      panel.border=element_blank(),
      panel.grid.major = element_line(color = "grey35"),
      panel.grid.minor = element_line(color = "grey20"),
      panel.spacing = unit(0.5, "lines"),
      # Specify facetting options
      strip.background = element_rect(fill = "grey30", color = "grey10"),
      strip.text.x = element_text(size = base_size*0.8, color = "white"),
      strip.text.y = element_text(size = base_size*0.8, color = "white",angle = -90),
      # Specify plot options
      plot.background = element_rect(color = " gray10", fill = " gray10"),
      plot.title = element_text(size = base_size*1.2, color = "white",hjust=0,lineheight=1.25,
                                margin=margin(2,2,2,2)),
      plot.subtitle = element_text(size = base_size*1, color = "white",hjust=0,  margin=margin(2,2,2,2)),
      plot.caption = element_text(size = base_size*0.8, color = "white",hjust=0),
      plot.margin = unit(rep(1, 4), "lines")

    )

}


