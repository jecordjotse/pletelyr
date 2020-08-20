
utils::globalVariables(c("quadgram", "trigram", "bigram", "unigram", "tail", "%>%", "desc","ngram","ngram.1","ngram.2","ngram.3","ngram.4","prob"))

#Predict Next Word
predict_next_word <- function(str ,quadgram, trigram, bigram, unigram){
    str <- gsub('><','> <',x = str)
    str <- gsub('\\s+',' ',x = str)
    s <- strsplit(tolower(gsub('[^a-zA-Z0-9\\s></]', "", str, perl = TRUE)), " ")[[1]]
    if(length(s)!=0){
        if(s[1]!='<s>'){
            str <- tolower(gsub('[^a-zA-Z0-9\\s]',"",str, perl = TRUE))
            str <- gsub('^','<s> ',x = str)
            str <- gsub('\\s+',' ',x = str)
            str <- strsplit(str, " ")[[1]]
        }else{
            str <- s
        }
    }else{
        str <- gsub('^','<s> ',x = str)
        str <- gsub('\\s+',' ',x = str)
        str <- strsplit(str, " ")[[1]]
    }
    gram <- "."
    if(length(str)>=3){
        pred <- tail(str,3)
        res <- (quadgram %>% dplyr::filter(ngram.1==pred[1],ngram.2==pred[2],ngram.3==pred[3]))[,c(4,6)]
        gram <- "quadgram"
        if(nrow(res)==0){
            res <- (trigram %>% dplyr::filter(ngram.1==pred[2],ngram.2==pred[3]))[,c(3,5)]
            gram <- "trigram"
            if(nrow(res)==0){
                res <- (bigram %>% dplyr::filter(ngram.1==pred[3]))[,c(2,4)]
                gram <- "bigram"
                if(nrow(res)==0){
                    res <- (unigram %>% dplyr::arrange(desc(prob)))[1000,c(1,3)]
                    gram <- "unigram"
                }
            }
        }
        #print(paste("Used", gram))
        res <- as.data.frame(res)
        results<- res %>% dplyr::mutate(prob = log(as.numeric(1*prob)))
        colnames(results) <- c("ngram","prob")
    }

    if(length(str)>=2&gram!='trigram'){
        pred <- tail(str,2)
        res <- (trigram %>% dplyr::filter(ngram.1==pred[1],ngram.2==pred[2]))[,c(3,5)]
        gram <- "tigram"
        if(nrow(res)==0){
            res <- (bigram %>% dplyr::filter(ngram.1==pred[2]))[,c(2,4)]
            gram <- "bigram"
            if(nrow(res)==0){
                res <- (unigram %>% dplyr::arrange(desc(prob)))[1000,c(1,3)]
                gram <- "unigram"
            }
        }
        #print(paste("tried trigram and used", gram))
        res <- res %>% dplyr::mutate(prob = log(as.numeric(0.8*prob)))
        if(exists('results')){
            res <- as.data.frame(res)
            colnames(res) <- c("ngram","prob")
            results<- rbind(res,results)
        }else{
            res <- as.data.frame(res)
            results <- res
            colnames(results) <- c("ngram","prob")
        }
    }

    if(length(str)>=1&gram!='bigram'){
        pred <- tail(str,1)
        res <- (bigram %>% dplyr::filter(ngram.1==pred[1]))[,c(2,4)]
        gram <- "bigram"
        if(nrow(res)==0){
            res <- (unigram %>% dplyr::arrange(desc(prob)))[1000,c(1,3)]
            gram <- "unigram"
        }
        #print(paste("tried bigram and used", gram))
        res <-res %>% dplyr::mutate(prob = log(as.numeric(0.6*prob)))
        if(exists('results')){
            res <- as.data.frame(res)
            colnames(res) <- c("ngram","prob")
            results<- rbind(res,results)
        }else{
            res <- as.data.frame(res)
            results <- res
            colnames(results) <- c("ngram","prob")
        }
    }

    if(gram!='unigram'){
        res <- (unigram %>% dplyr::arrange(desc(prob)))[1000,c(1,3)]
        #print("tried and used unigram")
        res <- res %>% dplyr::mutate(prob = log(as.numeric(0.4*prob)))
        colnames(res) <- c("ngram","prob")
        if(exists('results')){
            res <- as.data.frame(res)
            colnames(res) <- c("ngram","prob")
            results<- rbind(res,results)
        }else{
            results <- res
            colnames(results) <- c("ngram","prob")
        }
    }
    results <- results %>% dplyr::group_by(ngram) %>% dplyr::summarise(prob = mean(prob)) %>% dplyr::arrange(desc(prob))
    return(results)
}

getWords <- function(str, wordTable){
    if(str==''){
        str='.'
    }
    words <- wordTable[grep(paste0('^',tolower(str)), wordTable$ngram)[1:3],]
    return(words)
}


checkLastSpace <- function(str){
    return(grepl('\\s$', str, perl = TRUE))
}
