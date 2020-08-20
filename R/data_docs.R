#' Unigram model
#'
#' A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#' @format A data frame with 1million plus rows and 3 variables:
#' \describe{
#'   \item{ngram}{unigrams, for the set of words}
#'   \item{prob}{probability of the ngram}
#'   ...
#' }
#'
#' @source processed loacally by jerome
"unigram"

#' Bigram model
#'
#' A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#' @format A data frame with 1million plus rows and 4 variables:
#' \describe{
#'   \item{ngram.1}{bigrams, 1st word for the set of words}
#'   \item{ngram.2}{bigrams, 2nd word for the set of words}
#'   \item{prob}{probability of the ngram}
#'   ...
#' }
#'
#' @source processed loacally by jerome
"bigram"

#' Trigram model
#'
#' A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#' @format A data frame with 1million plus rows and 5 variables:
#' \describe{
#'   \item{ngram.1}{trigrams, 1st word for the set of words}
#'   \item{ngram.2}{trigrams, 2nd word for the set of words}
#'   \item{ngram.3}{trigrams, 3rd word for the set of words}
#'   \item{prob}{probability of the ngram}
#'   ...
#' }
#'
#' @source processed loacally by jerome
"trigram"

#' Quadgram model
#'
#' A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#' @format A data frame with 1million plus rows and 6 variables:
#' \describe{
#'   \item{ngram.1}{quadgrams, 1st word for the set of words}
#'   \item{ngram.2}{quadgrams, 2nd word for the set of words}
#'   \item{ngram.3}{quadgrams, 3rd word for the set of words}
#'   \item{ngram.4}{quadgrams, 4th word for the set of words}
#'   \item{prob}{probability of the ngram}
#'   ...
#' }
#'
#' @source processed loacally by jerome
"quadgram"
