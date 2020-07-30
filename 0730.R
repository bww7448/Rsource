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





