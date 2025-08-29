#' Function to create a copy of Figure 3 from Schaefer et. al. 2000.
#'
#' @param full_data data set to be plotted.
#' @param sample_date vector of dates.
#' @param concentration vector of numeric data.
#'
#' @returns Returns a plot.
#' @export
#'
#' @examples
#' hurricane_ions_plot(full_data, sample_date, concentration)
#' 


hurricane_ions_plot <- function(full_data, sample_date, concentration) {
  # scalar of the date of Hurricane Hugo
  hurricane_date <- ymd("1989-09-18") 
  # following code is the ggplot!
  ggplot(full_data, aes(x = sample_date, y = concentration)) +
    geom_line(aes(color = sample_id)) + # separates sites into different lines
    scale_color_manual(values = c("#3C153B", "#89BD9E", "#F0C987", "#DB4C40")) +
    facet_wrap(~ions, ncol = 1,  # wrap graphs by type of ion
               scales = "free_y",  # y axis is not static
               strip.position = "left") + # y axis labels are on the left
    # adds a vertical line indicating when Hurricane Hugo occured
    geom_vline(xintercept = hurricane_date, linetype = "dashed") + 
    theme_bw() + # base r populated themes
    theme(strip.background = element_blank(), # removes boxes on y axis labels
          strip.placement = "outside", # moves y axis labels outside the y axis values
          strip.text.y.left = element_text(angle = 90), # y axis labels are vertical
          axis.title.y = element_blank(), # removes overall y axis title (which was concentration)
          panel.spacing = unit(0, "lines"), # removes space between faceted plots
          panel.grid.major = element_blank(), # removes major grid lines
          panel.grid.minor = element_blank()) + # removes minor grid lines
    labs()
}