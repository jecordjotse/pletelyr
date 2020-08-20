#' Building an autocopleting fucntion to autocomplete or predict next word
#'
#' This function autocompletes whether to autocomplete the last set of characters or  predict a new word based on
#' previous words determined by the spaced variable. Spaced is true if you want a new word but to autocomplete based on
#' set of characters spaced is false
#'
#' @param str a string that contains the words to be used to predict next word
#' @param spaced a logical that determines where to complete the last set or characters or predict a new word
#' @return a data.frame containing the top 3 most likely words and their respective log probabilities
#' @author Jerome Cordjotse
#' @details
#' This function helps if you have an external trigger to determine whether to complete the word from the last
#' set of characters or predict a new word based on previous words
#' @export
autocomplete_checkingSpace <- function(str, spaced=T){
    if(spaced)
        getWords('',predict_next_word(str,quadgram,trigram,bigram,unigram))
    else{
        getWords( stringr::word(str,-1), predict_next_word(sub(str, pattern = " [[:alpha:]]*$", replacement = ""),quadgram,trigram,bigram,unigram))
    }
}

#' This function autocompletes by determining whether to  autocomplete the last set of characters or  predict a new word based on
#' previous words. The determining factor is the ending whitespace. Including an ending whitespace to signify new word, else
#' the predictor predicts the next word based on the last set of charactes in the string
#'
#' @param str a string that contains the words to be used to predict next word
#' @return a data.frame containing the top 3 most likely words and their respective log probabilities
#' @author Jerome Cordjotse
#' @details
#' End with a space if you hope to predict a new word based on previous words, else it will try to autocomplete the
#' last word as if was the beginning of an unknown predicted word
#' @export
autocomplete <- function(str){
    if(checkLastSpace(str))
        getWords('',predict_next_word(str,quadgram,trigram,bigram,unigram))
    else{
        getWords( stringr::word(str,-1), predict_next_word(sub(str, pattern = " [[:alpha:]]*$", replacement = ""),quadgram,trigram,bigram,unigram))
    }
}
