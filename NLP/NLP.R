# Installing  packages
install.packages('tm')
install.packages('twitteR')
install.packages('wordcloud')
install.packages('RColorBrewer')
install.packages("e1071", dep = TRUE, type = "source")
install.packages('class')
install.packages("base64enc")

library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

ckey = "__"
skey = "__"
token = 	"__"
sectoken = "__"

#Connect to twitter
setup_twitter_oauth(ckey,skey,token,sectoken)

##Returning tweets
soccer.tweets = searchTwitter('soccer',lang = 'en',n = 1000)

##grabbing text data from tweets
soccer.text  = sapply(soccer.tweets,function(x) x$getText())

##Clean the text data
soccer.text = iconv(soccer.text,'UTF-8','ASCII' ,sub="")

##
soccer.corpus = Corpus(VectorSource(soccer.text))

##
term.doc.matrix = TermDocumentMatrix(soccer.corpus,
                                     control = list(removePunctuation = TRUE,
                                                                  stopwords = c("soccer",
                                                                  stopwords("english")),
                                                                  removeNumbers=TRUE,
                                                                  tolower=FALSE))
                                                            
#####Convert object into a matrix
term.doc.matrix = as.matrix(term.doc.matrix)

##Get word counts

word.freq = sort(rowSums(term.doc.matrix),decreasing = TRUE)
dm = data.frame(word= names(word.freq),freq = word.freq)

##Create a word cloud
wordcloud(dm$word,dm$freq,random.order = FALSE,colors = brewer.pal(8,'Dark2'))





