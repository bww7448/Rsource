install.packages("multilinguer")
library(multilinguer)
install.packages(c('stringr', 'hash', 'tau', 
                   'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", force = TRUE, INSTALL_opts=c("--no-multiarch"))
library(KoNLP)


#print : 하나의 변수값만 출력 가능 / 하나의 변수만 출력
#cat : 텍스트를 삽입해서 출력가능 / 여러 변수 출력 가능
print_test <- c(1, 5, 7)
print_test1 <- c(2, 4, 6)
print(print_test)
print(print_test, print_test1)

cat(print_test, print_test1)
cat("첫번째는 홀수 = ", print_test, "두번째는 짝수 = ", print_test1)

#sprintf : formatting 함수!
i<-40
sprintf('나는 %d 살이다.', i)


#if문
x <- 10
y <- 5
z <- x * y
z

if(x*y > 40){ #산술 > 관계 > 논리
  cat("x*y의 결과는 40 이상입니다.\n")
  cat("x*y=", z, '\n')
  sprintf("x*y= %f", z)#print 위에서는 if문 내에 출력이 안됨(print에 덮이는 듯...)
  print(z)
  sprintf("x*y= %f", z) 
}else{
  cat("x*y의 결과는 40 미만입니다. x*y =", z, "\n")
}

score <- scan()
#score<- 85
result <- "low"
if (score >= 80){
  result <- "excellent"
  print(result)
}
result
cat("your score is", score, ", which is", result)

score<-90
if (score >= 90){  # 조건식1
  result = "A학점" # 조건식1 참
}else if(score >= 80){#조건식2
  result = "B학점"    #조건식1 거짓, 조건식2 참
}else if(score >=70){ #조건식3
  result = "C학점"    #조건식3 참
}else if(score >= 60){#조건식4
  result = "D학점"    #조건식4 참
}else{                
  result = "F학점"
}
cat("당신의 학점은 ", result) #당신의 학점은 --
print(result)

score <- 95
ifelse(score >= 80, "great", "low") #새로운 컬럼을 만들기에 유용하다.

#### 1-3 which()
##subsetting
#벡터 객체를 대상으로 특정데이터를 검색하는데 사용
#조건식을 만족하는 경우 해당 벡터 원소의 인덱스를 반환
#데이터 프레임에서 사용

no <- c(1:6)
name <- c("홍길동", "이순신", "강감찬", "유관순", "김유신", "고길동")
score <- c(85, 78, 89, 90, 74, 89)
exam <- data.frame(학번=no, 이름=name, 성적=score)
exam

#which() 함수를 이용하면 조건문의 True인 것들의 인덱스를 알 수 있다.
exam[4,]
exam$이름 == "유관순" #boolean 값을 출력한다.
exam[exam$이름 == "유관순",]
exam[which(exam$이름 == "유관순"),]
which(exam$이름 == "유관순")
which(exam$성적 == 89)

subset(exam, 이름 == "유관순")

####2. 반복문
#2-1. for()
i <- c(1:10)
i

d <- c() #빈 vector(숫자)
for (n in i){
  sprintf("값은 %d", n)
  print(n * 10)
  print(n)
  sprintf("값은 %d", n)
  d[n] <- n*2
  sprintf("값은 %.3f", n) #for문 내에서는 그냥 sprintf가 안먹힌다??
}
d

for(n in 1:length(i)){
  print(n*10)
  print(n)
  d[n] <- n*2
}
d

####1~30까지 짝수 값만 출력하는 반복문!
for (i in seq(1,15)){
  #print(2*i)
  sprintf("%d번째 짝수는 %d", i, 2*i)
  str <- sprintf("30까지 %d번째 짝수는 %d", i, 2*i) 
  #for문, if문 내에서 sprintf는 string을 만드는 함수이지 출력하는 함수가 아니다.
  #그러니 변수에 넣어주고 그 변수를 print해준다!
  print(str)
}

for (i in seq(1:30)){
  if(i%%2 == 0){
    str <- sprintf("%d는 짝수!", i)
    print(i)
    print(str)
    }
}

#1~20까지 짝수이면 넘기고(아무것도 하지 않고), 홀수면 *3해서 출력한다.
j <- 1:20
for (n in j){
  if(n%%2 == 0){
    next
  } else{
    print(n*3)
  }
}

score <- c(85, 95, 100)
name <- c("홍길동", "이순신", "강감찬")
for (i in 1:length(score)){
  str <- sprintf("%s -> %.2f", name[i], score[i])
  print(str)
}

for(n in 1:3){
  str<-cat(name[n], "->", score[n],'\n')
  str<-print(name[n], "->", score[n],'\n') ##얘네는 출력함수라서 스트링 값을 변수에 담을 수 없다.
}
str

####while()
#기본적으로for()와 동일
#다만, while 은 for와 달리 직접 반복 횟수를 결정하지 않고 블록내에서 증감식을 이용해 종료시점
#형식 : while(조건문){실행문}

j <- 1
while(j<5){
  print("남은 시험이 있습니다.")
  j <- j+1
}
i <- 10
while(i >= 0){
  if(i>0){
    str = sprintf("남은 커피는 %d 잔입니다.", i)
    print(str)}
  else{
    print("커피가 없습니다.")
    print("판매를 종료 합니다.")
    }
  i <- i-1
}


##user defined function
f_plus <- function(x, y){
  adding = x + y
  return(adding)
}

###9x9단 만들기
i<-2
while(i<10){
  j<-1
  str1 <- sprintf("*** %d단***",i)
  print(str1)
  while(j<10){
    str2 <- sprintf("%d * %d = %d", i, j, i*j)
    print(str2)
    j <- j+1
  }
  i <- i+1
  cat("\n")
}

### nxm단 함수로 만들기!
f_mine <- function(n, m){
  i<-2
  while(i< n+1){
    j<-1
    str1 <- sprintf("*** %d단***",i)
    print(str1)
    while(j< m+1){
      str2 <- sprintf("%d * %d = %d", i, j, f_cross(i, j))
      print(str2)
      j <- j+1
    }
    i <- i+1
    cat("\n")
  }
}

f_cross <- function(x, y){
  result = x * y
  return(result)
}

f_mine(15,12)


########word cloud

####1. 파일 불러 오기
Sys.setenv(JAVA_HOME = 'C:\\Program Files\\Java\\jre1.8.0_251')
install.packages('rJava')
library(rJava)
library(KoNLP)

seoul_data <- readLines(con = 'C:\\big data class\\R_edu\\rsource\\Rdata\\seoul.txt',
                        encoding = 'UTF-8')
seoul_data
####2. 명사 추출 --> KoNLP 패키지 이용
sdata <- sapply(seoul_data, KoNLP::extractNoun, USE.NAMES = FALSE)
sdata
sdata2 <- unlist(sdata)
sdata2

?gsub
sdata3 <- gsub("서울시","",sdata2)
sdata3 <- gsub("서울", "",sdata2)
sdata3 <- gsub("[0-9]+", "", sdata2)
sdata3 <- gsub("박원순", "", sdata2)
sdata3 <- gsub("-", "", sdata2)
sdata3 <- gsub("?", "", sdata2)
sdata3 <- gsub(" ", "", sdata2)
sdata3 <- gsub("\\.", "", sdata2)
sdata3
write(sdata3, "seoul_new.txt")
sdata4 <- read.table("seoul_new.txt")
sdata4
wdcount <- head(sort(table(sdata4), decreasing = T),30)

install.packages(c('RColorBrewer', 'wordcloud'))

library(RColorBrewer)
library(wordcloud)
palette<-brewer.pal(9, "Set1")

wordcloud(names(wdcount), freq= wdcount, scale = c(3,0.5),
        rot.per = 0.25, min.freq =1,
  random.order = F, random.color = T, colors=palette)

.libPaths()
buildDictionary(ext_dic = c("woorimalsam", "sejong"),
                replace_usr_dic = F)




katok_data <- readLines(con = 'C:\\big data class\\R_edu\\rsource\\Rdata\\katok.txt',
                        encoding = 'UTF-8')
kdata <- sapply(katok_data, KoNLP::extractNoun, USE.NAMES = FALSE)
kdata2 <- unlist(kdata)

kdata3 <- gsub("]", "", kdata2)
kdata3 <- gsub("[", "", kdata2)
kdata3 <- gsub("kfq", "", kdata2)
kdata3 <- gsub("박상명", "", kdata2)
kdata3 <- gsub("백원우", "", kdata2)
kdata3 <- gsub("김민수", "", kdata2)
kdata3 <- gsub("이유희", "", kdata2)
kdata3 <- gsub("정두영", "", kdata2)
kdata3 <- gsub("민국기", "", kdata2)
kdata3 <- gsub("김진혁", "", kdata2)
kdata3 <- gsub("오전", "", kdata2)
kdata3 <- gsub("오후", "", kdata2)
kdata3 <- gsub("성현", "", kdata2)
kdata3 <- gsub("[0-9]+", "", kdata2)
kdata3

write(kdata3, "kdata_new.txt")
kdata4 <- read.table("kdata_new.txt")
kdata4
wdcount2 <- head(sort(table(kdata4), decreasing = T),30)
wordcloud(names(wdcount2), freq= wdcount, scale = c(3,0.5),
          rot.per = 0.25, min.freq =1,
          random.order = F, random.color = T, colors=palette)

####GDP 상위 20개국``

GDP_rank = read.csv(file = 'http://databank.worldbank.org/data/download/GDP_PPP.csv',
                    encoding = 'UTF-8')
head(GDP_rank, 20)
str(GDP_rank)
summary(GDP_rank)
library(ggplot2)
install.packages("stringr")
library(stringr)
GDP_rank$X.3 <- gsub(',', "", GDP_rank$X.3)
GDP_rank$X.3 <- as.integer(GDP_rank$X.3)
GDP_rank$X.3 <- GDP_rank$X.3/1000
GDP_rank
str(GDP_rank)
barplot(GDP_rank$X.3[6:25], names.arg = GDP_rank$X.2[6:25], 
        col=rainbow(20), xlab ='Nations', ylab='unit($Billion)',
        ylim =  c(0,25000),
        main = '2018년 국가별 GDP 순위(상위 20개국)')

