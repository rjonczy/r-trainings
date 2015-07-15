library(tm)
library(wordcloud)

# url to some tweets to be mined
url <- "http://goo.gl/qo0OsZ"

data <- read.csv(url)


# create a Corpus
txt_corpus <- Corpus(VectorSource(data))

tm_map(txt_corpus, removePunctuation)
tm_map(txt_corpus, removeNumbers)
tm_map(txt_corpus, removeWords, stopwords('english'))

tdm <- TermDocumentMatrix(txt_corpus)
dtm <- DocumentTermMatrix(txt_corpus)

findFreqTerms(tdm, lowfreq = 5)
findAssocs(Matrix, 'word', 0.3)

f <- matrix(0, ncol=nrow(tdm), nrow=nrow(tdm))
colnames(f) <- rownames(tdm)
rownames(f) <- rownames(tdm)


for (i in rownames(tdm)) {   
    
    ff <- findAssocs(tdm, i, 0)    
    
    for  (j in rownames(ff)) {        
        f[j,i] = ff[j,]        
    }    
}

fd <- as.dist(f)
plot(hclust(fd, method="ward.D"))


matrix_c <- as.matrix(tdm)

freq <- sort (rowSums(matrix_c))  # frequency data

tmdata <- data.frame(words = names(freq), freq)

wordcloud(tmdata$words, tmdata$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))


