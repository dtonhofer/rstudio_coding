# ---
# Get information about the passed "R thing" and put it into a data frame
# which is then returned
# ---

jungle <- function(x) {

   names <- c( "typeof"
              ,"mode"
              ,"storage.mode"
              ,"attributes"
              ,"classes"
              ,"implicit class"
              ,"homogeneous"
              ,"matrix"
              ,"array")

   # "res" is a list with names; this is the value to be returned.
   # Initialize it with NAs at first.

   res <- rep(list(NA), length(names))
   attr(res, "names") <- names

   # str(x) outputs to terminal (why can't I capture the output?)

   # message("Structure via str(x)")
   # str(x)

   # -- storage mode

   res[["typeof"]] <- typeof(x)
   res[["mode"]]   <- mode(x)
   if (typeof(x) != storage.mode(x)) {
      res[["storage.mode"]] <- storage.mode(x)
   }
   else {
      res[["typeof"]] <- paste0(res[["typeof"]]," (same as 'storage.mode')")
      res[["storage.mode"]] <- NULL
   }

   # -- attributes (including 'class')

   if (!is.null(attributes(x))) {
      res[["attributes"]] <- listofy(names(attributes(x)));
   }
   else {
      res[["attributes"]] <- NULL
   }

   # -- class attribute

   if (!is.null(attr(x, "class"))) {
      res[["classes"]] <- listofy(class(x));
      res[["implicit class"]] <- NULL
   }
   else {
      res[["classes"]] <- NULL
      res[["implicit class"]] <- class(x)
   }

   # -- homogeneous type

   res[["homogeneous"]] <- is.atomic(x)
   res[["matrix"]]      <- is.matrix(x)
   res[["array"]]       <- is.array(x)
   if (res[["homogeneous"]]) {
      
   }



#   if (is.atomic(x) || is.list(x)) {
#      message("This is a vector of type: ", typeof(x), " and length: ", length(x))
#      if (is.recursive(x)) {
#         message("This is a list, also known as a 'recursive vector'")
#      }
#      if (is.atomic(x)) {
#         message("This is an atomic vector");
#      } 
#      if (is.atomic(x) & is.recursive(x)) {
#         message("The vector is both atomic and recursive. Something is wrong.")
#      }
#   }
#
#   else {
#      message("This is not a vector")
#   }

   return(res)
}

listofy <- function(l) {
   text <- ""
   addcomma <- FALSE
   for (name in l) {
      if (addcomma) {
         text <- paste0(text,",")
      }
      text <- paste0(text,"\"",name,"\"")
      addcomma <- TRUE
   }
   return(text)
}

bp <- function(txt,l) {
   message(paste0("=== ",txt," ==="))
   for (name in names(l)) {
      message(paste0("   ",sprintf("%20s = ",name),l[[name]]))
   }
}

bp("NULL", jungle(NULL))
bp("NA", jungle(NA))
bp("TRUE", jungle(TRUE))
bp("logical(0)", jungle(logical(0)))
bp("1", jungle(1))
bp("c(1)", jungle(c(1)))
bp("list(1)", jungle(list(1)))
bp("matrix(1)", jungle(matrix(1)))
bp("tibble(1)", jungle(tibble(1)))

