###########
library(tm)
###########
source <- DirSource(getwd()) 
MyCorpus <- Corpus(source, readerControl=list(reader=readPlain)) #load in documents
MyCorpus <-tm_map(MyCorpus, tolower) #Make lowerspace instance
MyCorpus <-tm_map(MyCorpus, stripWhitespace) #Make lowerspace instance
#MyCorpus <-tm_map(MyCorpus, removeWords, stopwords("english"))
dtm <-DocumentTermMatrix(MyCorpus)



