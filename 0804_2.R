#명사 추출
#여행지 조사(사전에 builddictionary 후 다시 추출)
install.packages('multilinguer')
library(multilinguer)
install.packages(c('stringer', 'hash', 'tau',
                   'Sejong', 'RSQLite','devtools'), type = 'binary')
install.packages('remotes')
remotes::install_github('haven-jeon/KoNLP', upgrade='never', force = TRUE, 
                        INSTALL_opts = c('--no-multiarch'))
library(KoNLP)
.libPaths()
library(rJava)
install.packages(c('RColorBrewer','wordcloud'))

library(RColorBrewer)
library(wordcloud)

#파일 불러오기
jeju_data <- readLines(con = './/jeju.txt')
head(jeju_data,3)

#명사 추출
jdata <- sapply(jeju_data,KoNLP::extractNoun,
                USE.NAMES = F)
head(jdata,3)

#단어 분리
jdata2 <- unlist(jdata)
head(jdata2,3)
jdata2

#불용어 제거
jdata3 <- gsub('제주','',jdata2)
jdata3 <-gsub('제주도','',jdata3)
jdata3 <-gsub('[0-9]+','',jdata3)
jdata3 <-gsub('오전','',jdata3)
jdata3 <-gsub('오후','',jdata3)
jdata3 <-gsub('/','',jdata3)
jdata3 <-gsub('\\.','',jdata3)
jdata3 <-gsub('-','',jdata3)
jdata3 <-gsub('?','',jdata3)
jdata3

jdata3 <- gsub('추천','',jdata3)
jdata3 <- gsub('흑돼지','',jdata3)
jdata3 <- gsub('가게','',jdata3)
jdata3 <- gsub('쪽','',jdata3)
jdata3 <- gsub('^ㅇ','',jdata3)
jdata3 <- gsub('것','',jdata3)
jdata3 <- Filter(function(x){nchar(x)>=2},jdata3)
jdata3 <-gsub('숙소','',jdata3)
jdata3 <-gsub('시간','',jdata3)
jdata3 <-gsub('여행','',jdata3)
jdata3 <-gsub('해안','',jdata3)
jdata3 <-gsub('코스','',jdata3)
jdata3 <-gsub('까지','',jdata3)
jdata3 <-gsub('드라이브','',jdata3)
jdata3 <-gsub('출발','',jdata3)
jdata3 <-gsub('예약','',jdata3)
jdata3 <-gsub('경유','',jdata3)
jdata3 <-gsub('관광지','',jdata3)
jdata3 <-gsub('일정','',jdata3)
jdata3 <-gsub('하게','',jdata3)
jdata3 <-gsub('도착','',jdata3)
jdata3 <-gsub('공항','',jdata3)
jdata3 <-gsub('이용','',jdata3)
jdata3 <-gsub('전망','',jdata3)
jdata3 <-gsub('하루','',jdata3)
# no <- readLines(con='./data/불용어.txt',
#                 encoding = 'UTF-8')
# 
# for( i in 1:length(no)){
#   place_re <- gsub(pattern = no[i],"",x = place_re)
# }


#데이터 저장
write(jdata3, 'jeju_new.txt')
#데이터 다시 불러오기
jdata4 <- read.table('jeju_new.txt')
jdata4

#빈도확인
wfreq <- head(sort(table(jdata4),decreasing = T),40)

palette <- brewer.pal(9,'Set1') #RcolorBrewer에서 제공해주는 함수
wordcloud(names(wfreq),freq = wfreq,scale = c(4,0.5),
          rot.per = 0.25, min.freq=1,
          random.order = F,random.color = T,colors = palette)



View(wfreq)
.libPaths()

#####################딕셔너리 활용하기#################








#데이터 프레임으로 변경
Jeju <- readLines(con='.//제주도dic.txt',
                  encoding = 'UTF-8')
Jeju_to <- data.frame(여행지 = Jeju, 형태 = 'ncn')
View(Jeju)
#user_dic에 추가
+1. user_dic의 의미가 중요!!!!
  +2. 내가 고민했던 것은 : 딕셔너리로 만든 결과와 jeju.txt에 있는 형태소를 어떻게 비교할지!
  +3. 하지만 아래와 같이 제주명소로 딕셔너리를 만들었고, 이것은 KoNLP 패키지 안에 자동적으로 참조되어 비교해 줌

KoNLP::buildDictionary()
buildDictionary(user_dic = Jeju_to,
                
                F) 

#파일 불러오기
jeju_data <- readLines(con = './/jeju.txt')
head(jeju_data,3)

#명사 추출
Jdata <- sapply(jeju_data,KoNLP::extractNoun,
                USE.NAMES = F)
View(Jdata)

#단어 분리
jdata2 <- unlist(Jdata)
head(jdata2,3)
jdata2

#데이터 저장
write(jdata3, 'jeju_new2.txt')
#데이터 다시 불러오기
jdata4 <- read.table('jeju_new2.txt')
jdata4

#빈도확인
wfreq <- head(sort(table(jdata4),decreasing = T),30)
?brewer.pal()
palette <- brewer.pal(6,'Dark2') #RcolorBrewer에서 제공해주는 함수
wordcloud(names(wfreq),freq = wfreq,scale = c(3,0.5),
          rot.per = 0.4, min.freq=1,
          random.order = F,random.color = T,colors = palette)
