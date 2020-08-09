#KoNLP패키지 설치 및 부착
install.packages("multilinguer")
library(multilinguer)
install.packages(c('stringr','hash','tau','sejong','RSQLite','devtools'), type = "binary")
install.packages("remotes")

remotes::install_github('haven-jeon/KoNLP', upgrade = "never", force =TRUE,
                        INSTALL_opts = c("--multiarch"))
library(KoNLP)
library(rJava)

#제주 데이터 불러오기
jeju_data <- readLines(
  con = "C:\\big data class\\R_edu\\rsource\\jeju.txt")
jeju_data
#제주 데이터 단어별로 나누기
jdata <- sapply(jeju_data, KoNLP::extractNoun,
                USE.NAMES = FALSE)
jdata
#unlist를 통해 list를 벡터화
jda <- unlist(jdata)
jda
#gsub를 통해 불용어 제거
jda <- gsub("다음","",jda)
jda <- gsub("[0-9]","",jda)
jda <- gsub('제주','',jda)
jda <-gsub('제주도','',jda)
jda <-gsub('[0-9]+','',jda)
jda <-gsub('거실','',jda)
jda <-gsub('오후','',jda)
jda <-gsub('/','',jda)
jda <-gsub('\\.','',jda)
jda <-gsub('-','',jda)
jda <-gsub('?','',jda)
jda <- gsub('추천','',jda)
jda <- gsub('흑돼지','',jda)
jda <- gsub('가게','',jda)
jda <- gsub('^[가-힣]','',jda)
jda <- Filter(function(x){nchar(x)>=2},jda)
jda <- gsub('제주','',jda)
jda <-gsub('제주도','',jda)
jda <-gsub('오전','',jda)
jda <-gsub('오후','',jda)
jda <-gsub('/','',jda)
jda <-gsub('\\.','',jda)
jda <-gsub('-','',jda)
jda <- gsub('추천','',jda)
jda <- gsub('흑돼지','',jda)
jda <- gsub('가게','',jda)
jda <- gsub('쪽','',jda)
jda <- gsub('^ㅇ','',jda)
jda <- gsub('것','',jda)
jda <-gsub('숙소','',jda)
jda <-gsub('시간','',jda)
jda <-gsub('여행','',jda)
jda <-gsub('해안','',jda)
jda <- gsub("가격", "", jda)
jda <- gsub("-"," ",jda)
jda <- gsub("?", "", jda)
jda <- gsub('/',' ',jda)
jda <- gsub("제주", "", jda)
jda <- gsub("추천", "", jda)
jda <- gsub("오전", "", jda)
jda <- gsub("오후", "", jda)
jda <- gsub("월일", "", jda)
jda <- gsub("시분", "", jda)
jda <- gsub("출발", "", jda)
jda <- gsub("도착", "", jda)
jda <- gsub("여행지", "", jda)
jda <- gsub('\\.','',jda) #마침표, ... 제거하기 위함
jda <- gsub("]", "", jda)
jda <- gsub("\\[", "", jda)
jda <- gsub("소", "", jda)
jda <- gsub("숙", "", jda)
jda <- gsub("해안", "", jda)
jda <- gsub("여행", "", jda)
jda <- gsub("것", "", jda)
jda <- gsub("곳", "", jda)
jda <- gsub("시간", "", jda)
jda <- gsub("날", "", jda)
jda <- gsub("분", "", jda)
jda <- gsub("코스", "", jda)
jda <- gsub("관광지", "", jda)
jda <- gsub("공항", "", jda)
jda <- gsub("전망", "", jda)
jda <- gsub("경유", "", jda)
jda <- gsub("까지", "", jda)
jda <- gsub("데", "", jda)
jda <- gsub("사진", "", jda)
jda <- gsub("하루", "", jda)
jda <- gsub("하게", "", jda)
jda <- gsub("하시", "", jda)
jda <- gsub("일정", "", jda)
jda <- gsub("예약", "", jda)
jda <- gsub("이용", "", jda)
jda <- gsub("가능", "", jda)
jda <- gsub("다양", "", jda)
jda <- gsub("관광", "", jda)
jda <- gsub("위치", "", jda)
jda <- gsub("산책", "", jda)
jda <- gsub("둘째", "", jda)
jda <- gsub("정도", "", jda)
jda <- gsub("드라이브", "", jda)
jda <- gsub("중간", "", jda)
jda <- gsub("대장","", jda)
jda <- gsub("다솜", "", jda)
jda <- gsub("[0-9]", "", jda)
jda <-gsub('코스','',jda)
jda
#wordcloud를 그리기 위한 패키지/색을 입히기 위한 Brewer
install.packages(c('RColorBrewer','wordcloud'))
library(RColorBrewer)
library(wordcloud)

table(jda)
#wordcount에서 빈도수에 따른 정렬
wdcount <- head(sort(table(jda),decreasing = T),30)
str(wdcount)
table(wdcount)
View(wdcount)
#색 지정
palette <- brewer.pal(9,"Set1")
#wordcloud 생성
wordcloud(names(wdcount),freq = wdcount, scale = c(3,3),
          rot.per = 0.2, min.freq=1,
          random.order= F, random.color = T, colors = palette)

#제주 dic를 만들기 위한 작업 - txt파일을 직접만듬
j_dic <- readLines(
  con = "C:\\big data class\\R_edu\\rsource\\제주도dic.txt", encoding = 'UTF-8'
)
j_dic
#딕셔너리에 ncn을 붙임
j_dic2 <- data.frame(관광지 = j_dic,ncn = "ncn")
j_dic2

#딕셔너리에 저장
KoNLP::buildDictionary()
buildDictionary(user_dic = j_dic2,
                replace_usr_dic = F)
#딕셔너리의 경로를 추적
.libPaths()
#사전의 정의를 통해 