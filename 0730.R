.libPaths()

help(table)
?table
#comment

# 여러줄을 한번에
# comment처리 하려면
# 블록잡고 ctrl+shift+c

# install.packages()
# installed.packages()
# data()
# str(), class(), mode()
# summary()
# min(), max(), mean(), median(), sum()
# table()

iris
iris_df <-iris
View(iris_df)

# table 사용 예
table(iris_df$Species)
table(iris$Species)
#벡터 만들기
c() #벡터를 만드는 함수
vec <- c(1,2,3,4,5)
#변수만들때 = 을 쓸수는 있지만 보통 쓰지는 않는다!
vec1 = c(1,2,3,4,5)

vec
vec[1] #R의 index는 0이 아닌 1부터 시작한다.(파이썬과 다름!)
vec[1, 4] #2가지 값을 가져오고 싶을때는 이렇게 쓰지 않는다.
#왜냐면 [1,4]는 2차원으로 접근하는 방법이기에!(파이썬에서 A[1][4]와 같은 형태)
vec[c(1,4)] #이렇게 사용한다.

vec_df
vec.df
2vec #이렇게 숫자가 먼저오는 변수는 사용하지 않는다.

vec2 <- vec*2
vec2    #vec의 각 값들에 2를 곱한 결과가 저장된다!


vec1 <- 1:5
vec1

str(vec1) #structure! not string
class(vec1) #data의 형태 -> 정수다!
mode(vec1) #data의 타입 -> 숫자다!

?seq #수열만들기!
vec2 <- seq(1,5,1)
vec2 <- seq(from =1, to = 5, by = 1)
vec2
vec2+2 #vec2의 각 값에 2를 더해준다!
vec2 <- vec2 + 1

seq(from=10, to = 50, by = 10)

vec3 <- "1" #문자열 형 데이터를 만드는 방법
vec3
vec3+1 #문자와 숫자는 연산이 불가능!
str(vec3)
class(vec3)
mode(vec3)

vec4 <- "홍길동"
vec4

vec5 <- c("홍길동","유관순순")
vec5

vec6 <- c(1, "홍길동")
vec6 #에러가 나지 않는다!(하지만 거의 모든 상황에서 
#이렇게 들어간건 에러랑 비슷한것이다. 1을 강제로 char로 변환)

a <- 1:100
a <- seq(1, 100, 1)
b <- mean(a)
mean(seq(1,100,1))
b

#시스템 날짜 확인
Sys.Date()
Sys.time()
date()

#문자형을 DATE로 변환
str('2020/6/16')
as.Date('2020/6/16')
aaa <- as.Date('2020/6/16')
aaa-1
as.Date('68/08/28', '%y/%m/%d')

#날짜 데이터가 미국식으로 다음과 같이 표현 돼 있다.
dt <- c('1-5-17', '18-7-20')
#한국식으로 표현되게 변경해 보세요.
dt1 <- as.Date(dt, '%d-%m-%y')
dt1

x <- c(1,3,5,7)
y <- c(3,5)

#합집합
union(x,y)
#교집합
intersect(x,y)
#차집합
setdiff(x,y)

english <- c(55,80,75,100)
english
#index에 name을 붙일 수 있다!
names(english) <- c('구동매', '고애신', '김희성', '이양화화')
english
english['구동매']

#데이터 값의 결측처리
#위의 영어성적에서 세번째 값이 결측돼 NA처리를 한다면??
english

english[3] <- NA
english


num <- 1:100
num
length(num)

num1 <- num[1:10]
num1
length(num1)

num2 <- num[c(1:10, 91:100, 16:25)]
num2
length(num2)
#index에도 연산을 할 수 있다!
num[11:(length(num)/2)]

num[c(2,4)]
#-index를 활용해 빼고 남은것들만 보는것도 가능하다!
num[-c(91:100)]
length(num[-c(91:100)])

#반올림
round(1.5)
round(pi,5) #표현하고 싶은 소수점 자릿수는 , 뒤에 적는다.
#올림
ceiling(1.4)
#내림
floor(1.6)

#진리값(True / False)
1 %in% c(1,3,5)
6 %in% c(1,3,5)

#범주형(factor)
#데이터가 특정 유형으로 구분됨
# 예1) 명목형(진보, 보수, 중도 / 남자, 여자) - 크기비교X
# 예2) 순서형(수,우,미,양,가 / 1등석, 2등석) - 순서를 들 수 있는 경우

summary(iris_df)
str(iris_df)

iris_df$Species <- as.character(iris_df$Species)
str(iris_df)

#정리 : 벡터의 기본성질
# 자료형이 아닌 자료구조
# 데이터의 순서(방향)을 가지는 1차원 구조
# 수치형 / 문자열형을 한 데이터에 같이 가질 수 없다.(2개의 타입 불가)


#매트릭스!
mat <- matrix(1:9, ncol = 3)
mat

mat1 <- matrix(1:9, ncol = 3, byrow = 'True')
mat1

#행이름, 열이름 붙이기!
mat2 <- matrix(1:9, nrow = 3, dimnames = 
    list (c("a1", "a2", "a3"), c("b1", "b2", "b3")))
mat2

#이름 붙이기
dimnames(mat)<-
  list(c("a1", "a2", "a3"), c("b1", "b2", "b3"))

colnames(mat) <- c("b1", "b2", "b3")
rownames(mat) <- c("a1", "a2", "a3")

#문자열형
#times를 사용해 a,b,c를 3번을 반복
rep(c("a", "b", "c"), times = 3)
mat3 <- matrix(rep(c("a", "b", "c"), times = 3), ncol = 3)
mat3
#each를 사용해 a 3번 b 3번 c 3번 반복
mat4 <- matrix(rep(c("a", "b", "c"), each = 3), ncol = 3)
mat4

#;를 통해 한줄에 2개의 명령을 넣는것도 가능하다!
rep(c("a", "b", "c"), times = 3);rep(c("a", "b", "c"), each = 3)

mat5 <- matrix(rep(c("a", "b", "c"), each = 4), ncol = 6, byrow = 'True')
mat5

mat5 <- matrix(1:6, ncol = 2)
mat5
#t를 사용해 transpose(전치 / 뒤집는다)를 할 수 있다.
t(mat5)

dim(mat5) # m by n 행렬인지 확인
nrow(mat5) # 행의 수 확인
ncol(mat5) # 열의 수 확인

#행과 열의 수를 바꿀 수 있다!
dim(mat5) <- c(2,3)
mat5

?matrix

#데이터의 길이가 열개수의 배수가 되지 않으면 error가 난다.
mat5 <- matrix(rep(c("a", "b", "c"), each = 4), ncol = 5, byrow = 'True')
#그럼 빈 곳은 NA/Null값으로 채우고 싶다면? 
#빈 곳에 default값을 넣고 싶다면?
#빈 곳에 다른 값들을 이용한 연산을 통해 추론된 값을 넣고 싶다면?

#apply
m <- matrix(1:9, ncol = 3, byrow = 'True')
m
apply(m,1,max) #행별 최대값
apply(m,2,mean) #열별 평균값
apply(m,2,min) #열별 최소값

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
