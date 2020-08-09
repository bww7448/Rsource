install.packages('mlbench')
library(mlbench)
data(Ozone)

ozo <- Ozone

###1. plot : 기본은 산점도
plot(ozo$V8, ozo$V9)
# 그러나 데이터의 형태에 맞는 그래프 표현해 주는 함수이다.
# ex) plot(iris) / plot()

#그래프 꾸미기
plot(ozo$V8, ozo$V9, xlab = 'Sandburg Temp',
     ylab = "El Monte Temp")

par(mfrow = c(2, 1), #2 X 1 pictures on one plots
    pty = "s")

plot(ozo$V8, ozo$V9, xlab = "Sandburg Temp",
     ylab = 'El Monte Temp', pch = 20, #pch로 점의 모양 설정
     cex = 0.5)

plot(ozo$V8, ozo$V9, xlab = "Sandburg Temp",
     ylab = 'El Monte Temp', pch = "+",
     cex = 0.7)

cars #속도와 제동거리
plot(cars, type = 'l')
par(mfrow = c(2,2), pty = 's')
plot(cars, type = 'b')
plot(cars, type = 'o')

###jitter() : 데이터에 약간의 노이즈를 추가함
tail(ozo[,c('V6', 'V7')], 10)

#동일한 값을 가지는 데이터가 많을 경우 좌표평면 상에 오버랩 문제
#값에 노이즈를 살짝 추가하여 겹치지 않도록 표현

par(mfrow = c(2,2), #
    pty = "s")
plot(ozo$V6, ozo$V7, xlab = 'Wind Spped',
     ylab = 'Humidity', pch = 15, cex = .5)
plot(jitter(ozo$V6), jitter(ozo$V7),
     xlab = 'Wind Spped', ylab = 'Humidity',
     pch = 15, cex = .5)

### pointS() : 이미 생성된 plot()에 점을 추가로 그려줌
data(iris)
View(iris)
with(iris, {
  plot(NULL, xlim = c(0,5), ylim = c(0,10),
       xlab = 'width', ylab = 'length',
       main = 'iris', type = 'n')
  points(Sepal.Width, Sepal.Length, cex = 1, pch="*", col = 'blue')
  points(Petal.Width, Petal.Length, cex = 1, pch="+", col = 'red')
})

###lenes() : 꺾은선
# ex1)
x <- seq(0, 2*pi, 0.1)
y <- sin(x)
plot(x, y, cex = 0.5, col = 'red')
lines(x, y)

###abline() : 직선(직선 형태의 보조선 추가)
# y = ax + b 형태의 직선이나 y = h, x = v 형태의 직선 등을 plot()에 추가
# ex1)
plot(cars, xlim = c(0, 25)); abline(a = -5, b = 3.5, col = 'red')

#ex2) cars데이터를 plot하고 세개의 보조선을 표현해 보세요
# 1) 기울기 : 3.2, 절편 : -10인 보조선
# 2) speed 변수의 편균값을 나타내는 보조선
# 3) dist 변수의 평균값을 나타내는 보조선

plot(cars, xlim = c(0,25))
abline(a = -10, b = 3.2, col='purple')
abline(h = mean(cars$dist), lty = 2, col='gray') #h : horizon
abline(v = mean(cars$speed), lty = 2, col='light gray') #v : vertical

### curve() : 곡선
curve(cos, 0, 2*pi)
abline(v = pi, lty = 15, col = 'light blue')

###annotation : 1) text()

#ex1)
plot(cars, cex = 0.5)
text(cars$speed, cars$dist, pos = 3, cex = 0.5)

###annot 2) identify()
plot(cars, cex = 0.5)
identify(cars$speed, cars$dist)

###legend() $범례 표시

plot(iris$Sepal.Width, iris$Sepal.Length, pch = 1,
     xlab = 'width', ylab = 'length', xlim = c(0, 5), ylim = c(0,8))
points(iris$Petal.Width, iris$Petal.Length, pch = "+", col = 'red')
legend('bottomright', legend = c("Sepal", "Petal"), pch = c(1,43),
       col = c('black', 'red'), bg = 'gray')

#3D scatter plot
install.packages('scatterplot3d')
library(scatterplot3d)

#데이터 불러오기
iris_setosa <- iris[iris$Species == 'setosa',]
iris_versicolor <- iris[iris$Species == 'versicolor',]
iris_virginica <- iris[iris$Species == 'virginica',]

# scatterplot3d(밑변, 오른쪽 변, 왼쪽 변)

#1. 3차원 프레임(틀) 생성
#2. 산점도 시각화

iris_d3 <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length,
                         iris$Sepal.Width, type = 'n', angle = 30)
iris_d3$points3d(iris_setosa$Petal.Length,
                 iris_setosa$Sepal.Length,
                 iris_setosa$Sepal.Width,
                 bg = 'red', pch = 21)
iris_d3$points3d(iris_versicolor$Petal.Length,
                 iris_versicolor$Sepal.Length,
                 iris_versicolor$Sepal.Width,
                 bg = 'blue', pch = 23)
iris_d3$points3d(iris_virginica$Petal.Length,
                 iris_virginica$Sepal.Length,
                 iris_virginica$Sepal.Width,
                 bg = 'green', pch = 25)

##------------------------------------------
boxplot(mpg$hwy)

#상자그림 통계치 출력
boxplot(mpg$hwy)$stats

#12~37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy >37, NA, mpg$hwy)

#결측치 확인
table(is.na(mpg$hwy))
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))
