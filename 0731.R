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
df_user$gender <- factor(df_user$gender, levels=c("남자","여자"))
df_user$gender <- as.factor(df_user$gender)
barplot(df_user$gender)
barplot(table(df_user$gender))
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
