# DataPreprocessing(데이터 전처리)
# 
# + 데이터를 불러온 후 입력된 자료에 오류가 없는지 확인하고 특이한 형태의 데이터를
# 개락적으로 분석하는 과정이 필요하다. 이러한 분석과정을 통해서 데이터를 정제하는
# 과정을 데이터 전처리라고 한다.(EDA)

# 1. 탐색적 데이터 조회
# 
# 1.1 데이터 셋 보기
# 
# [실습] 데이터 가져오기

library(dplyr)
library(ggplot2)
library(stringr)

setwd("C:\\big data class\\R_edu\\rsource\\Rdata")

dataset <- read.csv(file = "dataset.csv")
head(dataset)

table(is.na(dataset$resident))
summary(dataset)

names(dataset) #컬럼 이름들 한번에 보기
attributes(dataset) #특성 한번에 보기
str(dataset) #데이터 구조보기

x <- dataset$gender
y <- dataset$price
# 산점도 형태로 변수 조회
plot(x, y)

# [ 실습 ] [index] 형식으로 변수 조회
dataset[2] #2번째 컬럼
dataset[6] #6번째 컬럼
dataset[3,] #3번째 관찰치(행) 전체
dataset[,3] #3번째 변수(열) 전체

#[ 실습 ] [index] 형식으로 변수 조회
dataset[c("job", "price")]
dataset[c(2, 6)]

str(dataset)
dataset[c(1,2,3)]
dataset[c(1:3)]
dataset[c(2,4:6, 3, 1)]
datacet[-c(2)] #2번 컬럼 빼고 조회
reg <- str_extract_all(dataset, '[a-z]{3}')


#2.2 결측치 제거
[실습] sum() 함수에서 제공되는 속성 이용

sum(dataset$price, na.rm = T)
a <- seq(1:100)
a[1] <- NA
a
mean(a, na.rm = T)

dim(dataset)
dataset4 <- na.omit(dataset)
dim(dataset4)


price2 <- na.omit(dataset$price)
plot(dataset$price)
plot(price2)
sum(price2)
length(price2)


#2.3 결측치 대체
#[실습] 결측을 0으로 대체하기
x <- dataset$price
x[1:30]
dataset$price2 <- ifelse(!is.na(x), x, 0)#0으로 대체
dataset$price2 <- ifelse(is.na(x), 0, x)
dataset$price2[1:30]

x<- dataset$price
x[1:30]
dataset$price3 <- ifelse(!is.na(x), x, round(mean(x, na.rm = TRUE), 2))
#평균값으로 대체하기
dataset$price3[1:30]
a <- dataset[c('price', 'price2', 'price3')]
a
subset(a, is.na(price)) #a 중 price가 NA인것을 추출

# 3. 이상치(outlier) 처리

#[실습] 범주형 변수의 이상치 확인
table(dataset$gender)
pie(table(dataset$gender)) #파이차트 그리기

#실습 subset() 함수를 이용한 데이터 정제하기
dataset <- subset(dataset, gender ==1 | gender ==2)
length(dataset$gender)
pie(table(dataset$gender), col = c('red', 'blue'))

#3.2 연속형 변수의 극단치 처리
dataset6 <- subset(dataset, 2 <= price & 8 >= price)
length(dataset6$price)
dataset6$price
stem(dataset6$price)

#[실습] age 변수에서 NA 발견
summary(dataset6$age)
length(dataset6$age)

dataset7 <- subset(dataset6, age >= 20& age <= 69)
data_na <- na.omit(dataset6$age)
length(data_na)
length(dataset6$age)
boxplot(dataset6$age)

#아래 데이터 프레임의 test 변수의 NA를 평균으로 대체해 보세요
tt <- data.frame(test = c(1,3,8,4,3,4,NA,9))
tt
tt$test <- ifelse(is.na(tt$test), as.integer(mean(tt$test, na.rm = TRUE)), tt$test)

# 4. 코딩 변경
# 4.1 가독성(코딩변경)
#[실습]
# dataset6에 resident 변수의 1 --> 1.서울특별시
# 2 --> 2.인천광역시, 3 --> 3.대전광역시, 4 --> 4.대구광역시
#5 --> 5.시구군으로 표기하는 resident2 변수를 생성하세요.
x <- dataset6$resident
x
dataset6$resident2 <- ifelse(is.na(x), 'F. 자료없어요',
                      ifelse(x == 2, '2. 인천광역시',
                      ifelse(x == 3, '3. 대전광역시',
                      ifelse(x == 4, '4. 대구광역시',
                      ifelse(x == 5, '5. 부산광역시',
                      ifelse(x == 1, '1. 서울특별시',
                             x))))))
###########위와 아래의 차이가 뭘까??#########
dataset6$resident3 <- ifelse(x == 1, '1. 서울특별시',
                      ifelse(x == 2, '2. 인천광역시',
                      ifelse(x == 3, '3. 대전광역시',
                      ifelse(x == 4, '4. 대구광역시',
                      ifelse(x == 5, '5. 부산광역시',
                      ifelse(is.na(x), 'F. 자료없어요', x))))))
dataset6$resident2

dataset6$resident4 <- ifelse(x == 1, '1. 서울특별시',
                             ifelse(x == 2, '2. 인천광역시',
                                    ifelse(x == 3, '3. 대전광역시',
                                           ifelse(x == 4, '4. 대구광역시',
                                                  ifelse(x == 5, '5. 부산광역시','F. 자료없어요')))))
                                                         


View(dataset6)

dataset6$resident2[dataset6$resident == 1] <-'1.서울특별시'
dataset6$resident2[dataset6$resident == 2] <-'2.인천광역시'
dataset6$resident2[dataset6$resident == 3] <-'3.대전광역시'
dataset6$resident2[dataset6$resident == 4] <-'4.대구광역시'
dataset6$resident2[dataset6$resident == 5] <-'5.시구군'
dataset6$resident2[is.na(dataset6$resident)] <- 'F.자료없어요'


# [실습] job 칼럼을 대상으로 코딩 변경하기
dataset6$job2[dataset6$job == 1] <- '공무원'
dataset6$job2[dataset6$job == 2] <- '회사원'
dataset6$job2[dataset6$job == 3] <- '개인사업'

# 4.2 척도 변경을 위한 코딩 변경
# [실습] 나이(age) 변수를 청년층, 중년층, 장년층으로 코딩 변경하기
dataset6$age2[dataset6$age <= 30] <- '청년층'
dataset6$age2[dataset6$age > 30 & dataset6$age <= 55] <- '중년층'
dataset6$age2[dataset6$age > 55] <- '장년층'
head(dataset6)

y <- dataset6$survey
y[y == 5] <- '1'
y[y == 4] <- '2'
y[y == 3] <- '3'
y[y == 2] <- '4'
y[y == 1] <- '5'
y <- (6-y)
dataset6$survey <- as.numeric(y)
dataset6$survey
dataset$survey

##########dplyr 활용하기#############
exam <- read.csv('csv_exam.csv')
exam

install.packages('ggplot2')
library(ggplot2)

mpg_ex <- as.data.frame(ggplot2::mpg)

head(mpg)

df_raw <- data.frame (var1 = c(1,2,1),
                      var2 = c(2,3,2))
df_raw
df_new <- df_raw
df_new
######################################
df<- data.frame(var1 = c(4,3,8),
                var2 = c(2,6,1))
df$var_sum <- df$var1 + df$var2
df$var_mean <- (df$var1 + df$var2)/2
df
######################################
mpg_ex
mpg_ex$total <- (mpg_ex$cty + mpg_ex$hwy)/2
mean(mpg_ex$total)
summary(mpg_ex$total)
#히스토그램 만들기!
hist(mpg_ex$total)
#조건문을 이용한 파생변수 만들기
mpg_ex$test <- ifelse(mpg_ex$total >= 20, "pass", "fail") #조건, 참일때, 거짓일때때
head(mpg_ex, 8)
table(mpg_ex$test) #빈도표로 합격 판정 확인
qplot(mpg_ex$test) #빈도 막대그래프 생성
###중첩조건문 활용하기
mpg_ex$grade <- ifelse(mpg_ex$total >=30, "A",
                       ifelse(mpg_ex$total >= 25, "B", 
                              ifelse(mpg_ex$total >= 20, "C", "D")))
table(mpg_ex$grade)
qplot(mpg_ex$grade)
############################################
exam %>% filter(class == 1) #class가 1인 행만 출력한다!
#  %>%는 파이프 연산자로 부르고 ctrl+shift+m을 누르면 삽입된다.
# 파라미터 지정시에는 = / 같다는 의미는 ==
# filter는 subset(exam, class ==1)과 동일하게 쓴다.

exam %>% filter(class != 2) #2반이 아닌 경우!
exam %>% filter(math > 50) #math점수가 50 초과 인 경우!
#응용해서 > < >= <= 모두 가능!

exam %>% filter(class ==1 & math >=50) #&를 이용해 and연산 가능!
exam %>% filter(math>=90 | english >=90) #|를 이용해 or연산도 가능!
exam %>% filter(class %in% c(1,3,5)) #1,3,5반 출력 이렇게도 쓸 수 있다.

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)
mean(class2$science)

############################
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)

############################
exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3) %>% 
  arrange(desc(total)) %>% 
  head
exam
############################
exam %>%summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

exam_df <- exam %>% 
  group_by(class) %>%                      #class 별로 분리
  summarise(mean_math = mean(math),        #math 평균
            sum_math = sum(math),          #math 합계
            median_math = median(math),    #math 중앙값
            n = n())                       #학생 수
exam_df
str(exam_df)
str(exam)

mpg_ex %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

mpg_ex %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(tot = (cty+hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)

##가로로 합치기
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))
test2 <- data.frame(id = c(1,2,3,4,5, 6),
                    final = c(70, 83, 65, 95, 80, 90))

test1
total <- left_join(test1, test2, by = "id")
total

###left join은 NA 무시 / full join은 NA 포함

total2 <- full_join(test1, test2, by = 'id')
total2



name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")
exam_new


##세로로 합치기
group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60,80,70,90,85),
                      test2 = c(60,80,70,90,85))
group_b <- data.frame(id = c(6,7,8,9,10),
                      test = c(70,83,65,95,80))
group_all <- bind_rows(group_a, group_b)
group_all
