#' @title xts_tbl
#' @description This function converts data from a xts object to a tbl_df().
#' Note that the dataframe must be of type xts and ordered by a date column. This date column will be preserved and save as "date".
#' @param xts A xts series that will be converted to a tbl_df().
#' @param tidy Should data be returned in 'tidy' format.
#'
#' @return A tbl_df() with the first column the "date"  column used to order the xts series by.
#' @importFrom xts as.xts
#' @import zoo
#' @import dplyr
#' @import tidyr
#' @export
#' @examples
#' library(dplyr)
#' library(tidyr)
#' data(TRI)
#' TRI %>% tbl_xts(., cols_to_xts = "TRI", spread_by = "Country") %>% xts_tbl()


xts_tbl <- function(xts, tidy = T) {

  # Sanity Check -----------------------------------------------------------
  # ensure that column 1 is a valid date column:
  if ( class(xts)[1] !=  "xts") stop("Ensure that the supplied dataframe has class xts...")

  df <- data.frame(date=index(xts), coredata(xts)) %>% tbl_df()

  if(tidy){
    df <- df %>% gather(., group, rtn, -date)
  }

  df

}

