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