#' Calculating Moving Average for Irregular Sampling Dates
#'
#' @param focal_date Date of interest calculations will be done against.
#' @param dates Vector of dates.
#' @param conc Vector of numeric values to be averaged.
#' @param win_size_wks Window size for date range.
#'
#' @returns Returns a vector of numbers representing the average for the numeric vector within the designated date window.
#' @export
#'
#' @examples
#' moving_average(focal_date = as.Date("2001-12-04"),
#' dates = df$sample_date,
#' conc = df$concentrations,
#' win_size_wks = 9)
#' 

moving_average <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc)
  
  return(result)
}