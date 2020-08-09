# 1. 다음 조건에 맞게 client 데이터프레임을 생성하고 데이터를 처리해보세요
# + name : '유관순','홍길동','이순신','신사임당'
# + gender : 'F','M','M','F'
# + price : 50,65,45,75
# + 조건1 : 3개의 벡터 객체를 이용하여 client 데이터 프레임 생성
# + 조건2 : price 변수의 값이 65만원 이상이면, 문자열 'Best', 65만원 미만이면 'Normal'을 변수 result 컬럼에 추가
# + result 변수를 대상으로 빈도수 구하기
install.packages(dplyr)
library(dplyr)
client_df <- data.frame(name = c('유관순','홍길동','이순신','신사임당'),
                           gender = c('F','M','M','F'),
                           price = c(50,65,45,75))
client_df$result <- ifelse(client_df$price >= 65, 'Best', 'Normal')
client_df %>% 
  group_by(result) %>% 
  summarise(num = n())
# 2. 다음 벡터 EMP는 '입사년도이름급여' 순으로 사원의 정보가 기록된 데이터이다.
# 벡터 EMP를 이용하여 다음과 같은 결과가 나타나도록 함수를 정의해보세요
# (함수에 변수 EMP를 전달했을 때 출력결과와 같도록 만드시면 됩니다)
# + EMP <- c('2014홍길동220','2002이순신300','2010유관순260',"2019왕건500","2019동방신기1000")
# <출력결과>
#   전체 급여 평균 : 456
# 평균이상 급여 수령자
# 왕건 => 500
# 동방신기 => 1000
install.packages(c('stringr', 'hash', 'tau', 
                   'Sejong', 'RSQLite', 'devtools'), type = "binary")
library(stringr)
EMP <- c('2014홍길동220','2002이순신300','2010유관순260',"2019왕건500","2019동방신기1000", "2030싸이1100", "2024아이유1200", "2011소녀시대444"
, "2015정두영1050", "2020김민수666", "2010이유희777")
EMP
f_res <- function(EMP){
  EMP_year <- substr(EMP,1,4)
  EMP_name <- unlist(str_extract_all(EMP, '[가-힣]{2,4}'))
  EMP_sal <- unlist(str_extract_all(EMP, '[0-9]{1,}$'))
  EMP_df <- data.frame(year = EMP_year,
                       name = EMP_name,
                       sal = as.numeric(EMP_sal),
                       stringsAsFactors = FALSE)
  EMP_good <- EMP_df %>% 
    filter(EMP_df$sal > mean(EMP_df$sal))
  cat("전체 급여 평균 : ", mean(EMP_df$sal), "\n",
      "평균이상 급여 수령자", "\n")
  for (i in 1:nrow(EMP_good)){
    cat(EMP_good[i,2], "=>", EMP_good[i,3], "\n")
  }
}
f_res(EMP)

library(ggplot2)
?ggplot

ggplot(data = EMP_df
       , aes(x = name, y = sal)) + geom_col()


# 3. 함수 y = f(x)에서 x의 값이 a에서 b까지 변할 때 △x = b - a를 증분이라 하며,
# △y = f(b) - f(a)를 y의 증분으로 표현한다. 
# 평균변화율 : △y/△x = (f(b)- f(a))/(b - a) 
# 조건) 함수 f(x) = x^3 + 4에서 x의 값이 1에서 3까지 변할 때 평균변화율을
# 구하는 함수를 작성해보세요. (평균변화율 = (f(3)-f(1))/(3-1) = 13)
f <- function(x){
  a = x^3 +4
  return(a)
}

f_div <- function(x, y){
  d = (f(y) - f(x))/(y-x)
  print(d)
}
f_div(1,1.00000000000001)

# 4. 실습 : 몬테카를로 시뮬레이션
# 몬테카를로 시뮬레이션은 현실적으로 불가능한 문제의 해답을 얻기 위해서 난수의
# 확률분포를 이용하여 모의시험으로 근사적 해를 구하는 기법
# n번 시행했을 때 동전던지기의 확률을 구하라!
f_coin <- function(n){
  a = sample(x = 0:1, n, replace = TRUE)
  s = sum(a)
  p = s/n
  print(p)
}
f_coin(5000000)


f_mont <- function(p, n){
  pa <- p#ifelse(p>=0.5, 1-p, p)
  c = as.integer(1/pa)
  a = sample(x = 0:(c-1), n, replace = TRUE)
  s <- ifelse(a>0, 1, 0)
  d = sum(s)
  per <- 1-d/n#ifelse(p>=0.5, d/n, 1-(d/n))
  print(per)
}
f_mont(0.2, 100000)
f_mont(0.3,10000)


dbinom(x = 20, size = 100, prob = 0.2)

f_mont2 <- function(p, n){
  result <- 0
  for (i in 1:n){
    coin <- runif(1)
    if (coin<=p){
      result <- result +1
    }
  }
  prob <- result/n
  print(prob)
}
f_mont2(0.2, 10000)
