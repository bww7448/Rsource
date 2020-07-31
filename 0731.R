####3. 어레이(array)
#다차원 구조를 가진 데이터를 만들 때 사용
#즉, 벡터는 1차원 얼이, 매트릭스는 2차원 어레이로 생각할 수 있다.
#결론적으로 3차원 이상의 데이터 구조도 표현가능하다. ex)높이

arr1 <- array(1:12, dim = c(3,4))
arr1

arr2 <- array(1:12, dim = c(3,4), dimnames = 
                list(c("r1", "r2", "r3"), c("c1", "c2", "c3", "c4")))
#rownames(arr2) <- c("r1", "r2", "r3")
#colnames(arr2) <- c("c1", "c2", "c3", "c4")
arr2

mat1 <- matrix(1:12, nrow = 3)
mat1

mat2 <- matrix(1:12, nrow = 3, dimnames = 
                 list(c("r1", "r2", "r3"), c("c1", "c2", "c3", "c4")))

arr3 <- array(1:12, dim = c(2,2,3))
arr3

####4. 리스트(list)
a<- list(name = "Gildong", age = 30, job = "SalesManager")
a

b<- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
b
str(b)

c<- unlist(a)
c
str(c)
class(c)

d <- c('Gildong', 30, 'SalesManager')
names(d) <- c('name', 'age', 'job')
d


#####5. 데이터프레임(dataframe)

df <- data.frame(name = "Gildong", age = 20, job = "SalesManager")
df
str(df)

df1 <- data.frame(name = "Gildong", age = 20, job = "SalesManager",
      stringsAsFactors = FALSE)
df1
str(df1)

iris_df <- iris
str(iris_df)
summary(iris_df)

iris_df1 <- iris_df
iris_df1$Species <- as.character(iris_df1$Species)
summary(iris_df1)

##컬럼명 변경??
#사실상 덮어 쓰기의 개념이다!
names(df1) <- c('Names', 'Age', 'job')
df1

names(df1)[1] <- 'NAMES'
df1


#벡터는 1차원 어레이, 매트릭스는 2차원 어레이이며, 어레이는 n차원을 가질 수 있는 자료구조이다.
#벡터, 매트릭스, 어레이는 동일한 데이터 타입만을 가진다.(예: 수치형 벡터, 문자열형 매트릭스)
#리스트는 key/value 형식의 자료구조이며, 수치/문자열형 데이터 타입을 혼용할 수 있다.
#데이터프레임은 엑셀에서 다루는 일반 테이블 구조와 같으며, 수치/문자열형 데이터 타입을 혼용할 수 있다.


#연습문제 풀이
vec1 <- rep(c("R"), times = 5)
vec1

vec2 <- seq(1, 10, 3)
vec2

vec3 <- rep(seq(1, 10, 3), times = 3)
vec3

vec4 <- c(vec2, vec3)
vec4

vec <- seq(25, -15, -5)
vec

vec5 <- vec4[c(seq(1, length(vec4), 2))]
vec5
######################################2
df_user <- data.frame(name = c('최민수','유관순','이순신','김유신','홍길동'),
                      age = c(55,45,45,53,15),
                      gender = c(1,2,1,1,1),
                      job = c('연예인','학생','군인','직장인','무직'),
                      sat = c(3,4,2,5,5),
                      grade = c('C','C','A','D','A'),
                      total = c(44.4, 28.5,43.5,NA,27.1))             
install.packages("ggplot2")
library(ggplot2)
qplot(data = df_user, x = gender)
barplot(table(df_user$gender))
plot(as.factor(user$gender))
plot(iris)
#########################################3
df_score <- data.frame(kor = c(90, 85, 90),
                       eng = c(70, 85,75),
                       mat = c(86, 92, 88))
apply(df_score,2,max)
apply(df_score,1,max)

round(apply(df_score,2,mean),2)
round(apply(df_score,1,mean),2)

mat <- matrix(1:9, nrow = 3, dimnames = 
                list(c("a1", "a2", "a3"), c("b1", "b2", "b3")))

#모든 행과 2,3열
mat[1:3, 2:3]
mat[1:3, -1]
mat[,-1] #공백은 전체를 의미 #1만 뺀다
mat[c("a1", "a2", "a3"), c("b2", "b3")]

#2,3행과 1,2열
mat[2:3, 1:2]
mat[-1, -3]
mat[-1, 1:2]
mat[2:3, -3]
mat[c("a2", "a3"), c("b1", "b2")]

#어레이에서 첫번째 매트릭스의 모든 행에 대해 2열 데이터 인덱싱
arr <- array(1:12, dim = c(2,2,3))
arr[,2,1]
#세번째 매트릭스의 1행 1열 데이터 인덱싱
arr[1,1,3]
#모든 매트릭스의 2행 2열
arr[2,2,]

##리스트##
li<-list(name = c("GilDong", "SeDol"),
         age = c(30, 35),
         job = c("SalesManager", "GoPro"))
li

li$name[2]

li[2]
li[[2]] + 1
#[]와 [[]]는 출력되는 형태가 다르다!

df <- data.frame(name = c("GilDong", "SeDol"),
                 age = c(30,35),
                 job = c("SalesManager", "Gopro"))
#길동의 나이, 직업을 인덱싱
df[1,]
df[1, c("name", "age", "job")]

#데이터의 이름 컬럼 추출
df[,1]
df[,"name"]
df$name
df$n


# ##데이터 다루기 기본함수
# 우리가 다루는 데이터의 대부분은 데이터프레임 형식으로 돼 있다.
# 대다수의 데이터가 수치, 문자열, 팩터의 자료형을
# 혼합하여 가지고 있기 때문이다. 따라서 데이터프레임을 예로 들어
# 데이터를 다루기 위한 구체적인 기능들을 알아보자.

#행 또는 열을 추가할 때 : rbind, cbind

help(rbind)
help(cbind)
new_mem <- data.frame(name = c("Heungmin", "Hyunjin", "Jisung", "ChanHo"),
                      age = c(27, 31, 40, 45),
                      job = c("Footballplayer", "Baseballplayer",
                              "FootBallplayer", "Baseballplayer"))
df <- rbind(df, new_mem)
df

new_nat <- data.frame(nationality = c("Korea", "Korea", "Korea", "Korea", "Korea", "KOrea"))
df <- cbind(df, new_nat)
str(df)

#cbind 보다는 아래 방법을 더 많이 쓴다!
df$city <- c("한양", "서울", "토튼햄", "로스앤젤레스", "서울", "서울")
df


#성 컬럼 추가
df$surname <- c("Hong", "Lee", "Son", "Ryu", "Park", "Park")
df

#거주도시를 영문으로 변경
df$city <- c("Hanyang", "Seoul", "Tottenham", "LosAngeles", "Seoul", "Seoul")
df

#길동의 나이를 34세로 변경
df[1,2] <- 34
df

# 길동의 국적을 chosun으로 변경
df$nationality <- as.character(df$nationality)
df[1, 4] <- "chosun"
df

Sys.setenv(JAVA_HOME = 'C:\\Program Files\\Java\\jre1.8.0_251')
install.packages(c('rJava', 'xlsx'))

library(rJava)
library(xlsx)
student <- read.table(file=
      'C:\\rsource\\Rdata\\student.txt', sep = "", header = F)
student
#맨 위에 컬럼명이 있다면 header가 True라고 알려줘야 한다!
# sep : seperate!(파이썬으로 따지면 split?)

a <- runif(10)
a

seque <- 1:10

a_df <- data.frame(num=a, sequence = seque)
a_df

order(a_df$num, decreasing = T)
#인덱스 값이 반환된다.

b <- a_df[order(a_df$num, decreasing = T),]
b
#R에서는 경로를 들어갈때 \\를 쓴다.
student1 <- read.table(file=
            'C:\\rsource\\Rdata\\student1.txt', sep = "", header = T)
student1
student2 <- read.table(file=
            'C:\\rsource\\Rdata\\student2.txt', sep = ";", header = T)
student2

head(student2,2)
#head함수를 활용해서 data frame의 원하는 행만큼 출력할 수 있다.(default = 6)

View(student2)

setwd('C:\\rsource\\Rdata') #경로를 미리 설정해 줄 수 있다!
#set working directory
student1_1 <- read.table(file = 'student1.txt', header = TRUE, sep = '')
student1_1

student1_2 <- read.table(file = file.choose(), header = TRUE)


##dataframe을 tibble로 바꾸면 상위 10개만 출력해준다.
install.packages('tibble')
library(tibble)

iris_df <- iris
iris_df1 <- as_tibble(iris_df)
iris_df1

#vignette을 이용해 패키지의 정보를 볼 수 이따.
vignette('tibble')

student3 <- read.table(file = 'student3.txt', header = TRUE, sep = '', na.strings='-')#-을 NA로 처리해서 읽어온다.
student3
student3[3,4]

student4 <- read.table(file = 'student4.txt', header = TRUE, sep = ',', na.strings=c('-', '+', '$'))
student4

####엑셀파일
library(xlsx)
studentex <- read.xlsx('studentexcel.xlsx', sheetIndex = 1, encoding = "UTF-8")
studentex

USArrests
USArrests_df <- USArrests
USArrests_df

USArrests_df$murder_pop <- USArrests$Murder / USArrests$UrbanPop
USArrests_df <- tibble::rownames_to_column(USArrests_df)
USArrests_df
rank <- USArrests_df[order(USArrests_df$murder_pop, decreasing = T),]
barplot(rank$murder_pop[1:7], names.arg = rank$rowname[1:7], 
        col=rainbow(7), xlab ='state', ylab='murder/pop', 
        main = '인구밀도대비 살인율')


####문자열처리
install.packages("stringr")
library(stringr)

형식) str_extract('문자열', '정규표현식')

#연속으로 나오는 2개 숫자 추출 1개만
str_extract("홍길동35이순신45유관순25", "[0-9]{2}")
#연속으로 나오는 2개 숫자 추출 전부 다다
str_extract_all("홍길동35이순신45유관순25", "[0-9]{2}")

unlist(str_extract_all("홍길동35이순신45우관순25", "[0-9]{2}"))
#unlist로 list의 형태를 풀어준다!->벡터가 된다.

string <- 'hongkildong105lee1002you25강감찬2005'
str_extract_all(string, '[a-z]{3}')
str_extract_all(string, '[a-z]{3,}')
str_extract_all(string, '[a-z]{3,5}')

string1 <- 'YEShongkildong105lee1002you25강감찬2005'
str_extract_all(string1, '[A-z]{3}')
str_extract_all(string, 'hong')
str_extract_all(string, '25')
str_extract_all(string, '[가-힣]{3}')
str_extract_all(string, '[a-z]{3}')
#파이썬의 replace 같은거
gsub('영', "0", '홍영기')
gsub('영', "", '홍영기')
#영어 소문자 제외하고 추출
str_extract_all(string1, '[^a-z]{1,}')
#영어 소문자 제외, 4개 연속 붙은 것 추출
str_extract_all(string1, '[^a-z]{4}')
#한글제외, 5개 연속 붙은것
str_extract_all(string1, '[^가-힣]{5}')

jumin <- '123456-3234567654321-3589621'
unlist(str_extract_all(jumin,'[0-9]{6}-[0-9]{7}'))

name<-'홍길동1234,이순신5678,강감찬1012'
nm <- unlist(str_extract_all(name, '[가-힣]{3}'))
num<- unlist(str_extract_all(name, '[0-9]{4}'))

name_df <- data.frame(이름 = c(nm), 학번 = c(num))
name_df
