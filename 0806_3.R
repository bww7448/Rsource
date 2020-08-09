set_install <- function(){
  install.packages("multilinguer")
  install.packages(c('stringr', 'hash', 'tau', 
                     'Sejong', 'RSQLite', 'devtools'), type = "binary")
  install.packages("remotes")
  remotes::install_github('haven-jeon/KoNLP', upgrade = "never", force = TRUE, 
                          INSTALL_opts=c("--no-multiarch"))
  install.packages(c('RColorBrewer','wordcloud'))
}
set_install()
##############################################################################
set_library <- function(){
  library(dplyr)
  library(ggplot2)
  library(stringr)
  library(multilinguer)
  library(KoNLP)
  library(rJava)
  library(RColorBrewer)
  library(wordcloud)
  library(httr)
  setwd("C:\\big data class\\R_edu\\rsource\\Rdata")
}
set_library()
##############################################################################
blog_f <- function(ser){
  clientID <- 'J1lJ9MoEmKsdD31sFhdh'
  clientPW <- 'O56u4qI0Uc'
  urlStr <- "https://openapi.naver.com/v1/search/blog.xml?"
  searchQuery <- paste("query=", ser, sep = "")
  searchStr <- iconv(searchQuery, to="UTF-8")
  searchStr <- URLencode(searchStr)
  otherStr <- "&display=100&start=1&sort=sim"
  reqURL <- paste(urlStr,searchStr, otherStr, sep = "")
  apiResult <- httr::GET(reqURL, 
                         add_headers("X-Naver-Client-Id" = clientID, 
                                     "X-Naver-Client-Secret" = clientPW))
  blogData <- rawToChar(apiResult$content)
  Encoding(blogData) <- "UTF-8"
  CopyData <- gsub("<.*?>", "", blogData) #html 태그 제거
  CopyData <- gsub("[[:punct:]]", "", CopyData) #//제거
  CopyData <- gsub("[A-z]{1,}", "", CopyData)
  CopyData <- gsub("[0-9]{1,}", "", CopyData)
  CopyData <- gsub("[ㅋ]{1,}", "", CopyData)
  CopyData <- gsub("[ㅎ]{1,}", "", CopyData)
  CopyData <- gsub("[ㅜ]{1,}", "", CopyData)
  CopyData <- gsub("[♥]{1,}", "", CopyData)
  return(CopyData)
}
##############################################################################
build_dic_f <- function(){
  test <- read.table(file = "ggd.csv", fileEncoding = 'UTF-8', header = T,
                      fill = T, sep = '|', quote = "")
  new_dic <- test %>% 
    select(상호명) %>% 
    filter(!is.na(상호명))
  write.table(new_dic, file = "aaa.txt",
              row.names = TRUE, col.names = NA)
  test2 <- read.table(file = "aaa.txt")
  new_dic2 <- data.frame(가게 = test2$V2, ncn = "ncn")
  buildDictionary(user_dic = new_dic2,
                  replace_usr_dic = T)
  return (new_dic2)
}
##############################################################################
make_ncn_f <- function(result){
  result2 <- sapply(result, KoNLP::extractNoun,
                  USE.NAMES = FALSE)
  result3 <- unlist(result2)
  return(result3)
}
##############################################################################
cloud_f <- function(data){
  wdcount <- head(sort(table(data), decreasing = T),30)
  wordcloud(names(wdcount),freq = wdcount, scale = c(1,3),
            rot.per = 0.1, min.freq=2,
            random.order= F, random.color = T, colors = palette)
  }
##############################################################################
gsub_f <- function(result2){
  result2 <- gsub("사당동", "", result2)
  result2 <- gsub("이수", "", result2)
  result2 <- gsub("회식", "", result2)
  result2 <- gsub("추천", "", result2)
  result2 <- gsub("사당역맛집", "", result2)
  result2 <- gsub("유명", "", result2)
  result2 <- gsub("방문", "", result2)
  result2 <- gsub("돈", "", result2)
  result2 <- gsub("장소", "", result2)
  result2 <- gsub("서울", "", result2)
  result2 <- gsub("곳", "", result2)
  result2 <- gsub("고기집", "", result2)
  result2 <- gsub("술집", "", result2)
  result2 <- gsub("기집", "", result2)
  result2 <- gsub("근처", "", result2)
  result2 <- gsub("친구", "", result2)
  result2 <- gsub("삼겹살", "", result2)
  result2 <- gsub("분위기", "", result2)
  result2 <- gsub("모임", "", result2)
  result2 <- gsub("하", "", result2)
  result2 <- gsub("전", "", result2)
  result2 <- gsub("나", "", result2)
  result2 <- gsub("고기", "", result2)
}
##############################################################################
set_library()
result <- blog_f("수지 맛집")
result
result <- gsub_f(result)
result2 <- make_ncn_f(result)

cloud_f(result2)
############################
install.packages('readr')
library(readr)
test <- read_delim(file = "ggd.csv", col_names = T, delim = "|")
test2 <- read.table(file = "ggd.csv", fileEncoding = 'UTF-8', header = T,
                    fill = T, sep = '|', quote = "")
View(test)
View(test2)
table(test)
test %>% filter(상권업종대분류명 == "숙박" & 시군구명 == "남양주시" &
                          상권업종중분류코드 == "O03")
result2 <- sapply(result, KoNLP::extractNoun, USE.NAMES = FALSE)
result3 <- unlist(result2)
.libPaths()

library(rJava)
library(KoNLP)
?buildDictionary
buildDictionary(ext_dic = c('sejong'))

result
################################################################
set_library()
build_dic_f()
test
View(test)
