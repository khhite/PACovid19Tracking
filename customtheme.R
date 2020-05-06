# create custom theme
theme_custom <- function (base_size = 10, base_family = "sans") {
  half_line <- base_size/2
  theme_light(base_size = base_size, base_family = base_family) %+replace%           # basic theme to start
    theme(
      line = element_line(colour = "black", 
                          size = 0.5, 
                          linetype = 1, 
                          lineend = "butt"), 
      rect = element_rect(fill = "white",                                              # background
                          colour = "black", 
                          size = 0.5, 
                          linetype = 1),
      text = element_text(family = base_family,                                        # text
                          face = "plain",
                          colour = "black", 
                          size = base_size,
                          lineheight = 0.9,  
                          hjust = 0.5,
                          vjust = 0.5, 
                          angle = 0, 
                          margin = margin(), 
                          debug = FALSE), 
      
      axis.line = element_blank(),                                                     # chart border
      axis.text = element_text(size = rel(0.8), colour = "grey20"),                    # axis text
      axis.text.x = element_text(angle = 45, hjust = 1, margin = margin(t = 0.8*half_line/2), vjust = 1),     # axis x label text
      axis.text.y = element_text(margin = margin(r = 0.8*half_line/2), hjust = 1),     # axis y label text
      axis.ticks = element_line(colour = "grey20"),                                    # axis tick marks
      axis.ticks.length = unit(half_line/2, "pt"),                                     # axis tick mark length
      axis.title.x = element_text(size = rel(1),  face = "bold",                       # styles the x axis title
                                  margin = margin(t = 10, r = 0, b = 0, l = 0)),
      axis.title.y = element_text(size = rel(1),  face = "bold", angle = 90,           # styles the y axis title
                                  margin = margin(t = 0, r = 15, b = 0, l = 0)),
      
      legend.background = element_rect(fill = "transparent", colour = NA ),            # legend background and border
      legend.spacing.x = unit(0.2, 'cm'),                                              # category spacing
      legend.key = element_rect(fill = "transparent", colour = "transparent"),         # category background and border
      legend.key.size = unit(1.2, "lines"),                                            # category item size
      legend.key.height = NULL,                                                        # category item height
      legend.key.width = NULL,                                                         # category item width
      legend.text = element_text(size = rel(0.8)),                                     # legend category item text size
      legend.text.align = NULL,
      legend.title = element_text(hjust = 0), 
      legend.title.align = .5,                                                         # alignment of legend title (0-1 is left-right)
      legend.position = "top",                                                      # sets the location of the legend relative to the grid
      legend.direction = NULL,
      legend.justification = "center",                                                 # aligns the legend
      legend.box = NULL, 
      
      panel.background = element_rect(fill = "white", colour = "grey20"),                   # sets the chart panel background
      panel.border = element_blank(),                                                  # sets the chart panel border
      panel.grid.major = element_line(colour = "white"),                               # sets the chart grid line
      panel.grid.minor = element_line(colour = "white", size = 0.25), 
      #panel.margin = unit(half_line, "pt"), 
      panel.margin.y = NULL, 
      panel.margin.x = NULL,
      panel.ontop = FALSE, 
      
      strip.background = element_rect(colour="navyblue", fill="navyblue", size=1.5, linetype="solid"),
      strip.text = element_text(colour = "grey10", size = rel(0.8)),
      strip.text.x = element_text(size = 10, color = "white", face = "bold.italic", margin = margin(t = half_line, b = half_line)), 
      strip.text.y = element_text(angle = -90, 
                                  margin = margin(l = half_line, r = half_line)),
      strip.switch.pad.grid = unit(0.1, "cm"),
      strip.switch.pad.wrap = unit(0.1, "cm"), 
      
      plot.background = element_rect(colour = "white"),                               # sets the figure background color
      plot.title = element_text(size = rel(1.2), face = "bold",                       # styles the chart title
                                hjust = 0.5, vjust = 2.5,
                                margin = margin(b = half_line * 1.2)),
      plot.subtitle = element_text(size = 10, face="italic"),
      plot.margin = margin(half_line, half_line, half_line, half_line),
      
      complete = TRUE)
}