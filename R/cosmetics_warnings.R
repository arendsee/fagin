#' Collate the warnings of a Biostrings::translate function
#'
#' The Biostrings::translate function emits one warning for each CDS that is
#' not a multiple of 3. This function collates all these warnings into one.
#' Also it specifies the name of each sequence and the species from whch they
#' derive.
#'
#' The warning is assumed to have the form:
#' "in 'x[[123]]': last 2 bases were ignored"
#' "in 'x[[456]]': last base was ignored"
#'
#' @param node Rmonad object wrapping the result of a Biostrings::translate function
#' @param label The species name, usually
#' @return Rmonad An Rmonad object with a modified warning field
make_format_translation_warning <- function(label=NULL){
  # This function will be used within rmonad as a `format_warnings`
  # post-processor. Arguments: x - the output value of the Rmonad; ws - the
  # character vector of warnings.
  function(x, ws){
    node_ids <- which(grepl("base.*ignored", ws))
    model_ids <- as.integer(sub(
      "in 'x\\[\\[(\\d+)\\]\\]': .*base.*ignored",
      "\\1",
      ws[node_ids],
      perl=TRUE
    ))
    if(length(model_ids) > 0){ 
      n <- length(model_ids)
      total <- length(x)
      truncated <- paste0(names(x[model_ids]), collapse=', ')
      msg <- glue::glue(.sep="\n",
        "{.label(label)}{n} of {total} gene models are truncated (CDS length is not a",
        "multiple of 3). This is AFTER adjusting for cases where the phase of the",
        "first CDS is not 0 (which means that the model is incomplete on the 5'",
        "end). So these are cases of 3' truncation. Also note that truncated models",
        "that happen to end in phase will not be detected: [{truncated}]"
      )
      # replace the errors associated with truncation 
      ws <- c(msg, ws[-node_ids])
    }
    ws
  }
}
