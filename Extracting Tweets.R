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
#Choosing "SrBachchan" Twitter account(Amitabh Bachchan)
t <- getUser("SrBachchan")
mytweet <-userTimeline(t,n=685)#Selecting latest 685 Tweets
mytweet
mytweetdf <- twListToDF(mytweet)
write.csv(mytweetdf,file="AmitabhTweets.csv",row.names = FALSE)
