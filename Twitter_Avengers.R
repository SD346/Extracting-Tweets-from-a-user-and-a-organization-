install.packages("twitteR")
install.packages("ROAuth")
install.packages("RCurl")
library("twitteR")
library("ROAuth")
library("RCurl")
#Go to https://apps.twitter.com
#Register API using Twitter account

#API Tokens
api_key <- "vN0AB1UhZt2fNYhSz2vVrA4Ka"
api_secret <- "0q8nCoMBs0LXYcecUMQn6RJ0LruZqEBe6XimuLYIuDOeBMYeon"
access_token <- "79080220-41R92GMLzAv6KTgLeW3qyySuRzyNjxLw4KmQPjfBu"
access_token_secret <- "Jw0xJ8UkB1Anm5dgGYEDkwnbi5umwIEK1ro8c1kygsGBx"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

#User timeline
#Choosing "The Avengers" Twitter account
t <- getUser("Avengers")
mytweet <-userTimeline(t,n=300)#Selecting latest 300 Tweets
mytweet
mytweetdf <- twListToDF(mytweet)
write.csv(mytweetdf,file="Tweets.csv",row.names = FALSE)
Tweet <- read.csv(file.choose(),stringsAsFactors = F)
str(Tweet)

#Build Corpus
library(tm)
corpus <- iconv(Tweet$text, to = 'utf-8')
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])

#Clean text
corpus <- tm_map(corpus,tolower)
inspect(corpus[1:5])

corpus <- tm_map(corpus,removePunctuation)
inspect(corpus[1:5])

corpus <- tm_map(corpus,removeNumbers)
inspect(corpus[1:5])

corpus <- tm_map(corpus,removeWords,stopwords('english'))
inspect(corpus[1:5])

removeURL <- function(x) gsub('http[[:alnum:]]*','',x)
corpus <- tm_map(corpus,content_transformer(removeURL))
inspect(corpus[1:5])

corpus <- tm_map(corpus, stripWhitespace)
inspect(corpus[1:5])

#Term document matrix
tdm <- TermDocumentMatrix(corpus)
tdm

tdm <- as.matrix(tdm)
tdm[1:10, 1:20]

corpus <- tm_map(corpus,removeWords,c('marvel')) #Removing the common word Marvel
inspect(corpus[1:5])

#New Term document matrix
tdm <- TermDocumentMatrix(corpus)
tdm

tdm <- as.matrix(tdm)
tdm[1:10, 1:20]

#Bar plot
w <- rowSums(tdm)
w <- subset(w,w>=25)
barplot(w,las=2,col=rainbow(50))

#Wordcloud
library(wordcloud)
w <- sort(rowSums(tdm),decreasing = TRUE)
set.seed(222)

#Building the wordcloud
wordcloud(words = names(w),freq = w)

#Designing the wordcloud
wordcloud(words = names(w),freq = w,max.words = 300,random.order = F,
          min.freq = 2,colors = brewer.pal(8,'Dark2'),
          scale = c(3,0.5),rot.per = 0.7)

#Sentiment analysis
install.packages("syuzhet")
library(syuzhet)
library(ggplot2)
library(scales)
library(reshape2)

#Obtain sentiment scores
Tweet1 <- read.csv(file.choose(),header = T)
corpus1 <- iconv(Tweet1$text, to ='utf-8')
s <- get_nrc_sentiment(corpus1)
head(s)

#Barplot
barplot(colSums(s),las=2,col=rainbow(10),
        ylab='Count',main='Sentiment Scores for Avenger Tweets')

#Most of the tweets are Negative
