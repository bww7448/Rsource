#네이버 개발자 센터
#https://developers.naver.com/


# 1. ID / PW 저장
clientID <- 'J1lJ9MoEmKsdD31sFhdh'
clientPW <- 'O56u4qI0Uc'

# 2. 기본 URL
urlStr <- "https://openapi.naver.com/v1/search/blog.xml?"

# 3. 검색어 설정 및 UTF-8 URL encoding
searchQuery <- "query=발리 여행"

# 3-1. UTF-8 인코딩
searchStr <- iconv(searchQuery, to="UTF-8")

# 3-2. URL 인코딩
searchStr <- URLencode(searchStr)

searchStr

# 4. 나머지 요청변수 설정(유사도 정렬)
otherStr <- "&display=100&start=1&sort=sim"

# 5. URL 완성
reqURL <- paste(urlStr,searchStr, otherStr, sep = "")

reqURL
#########################################


# 6. httr 패키지(GET() 이용 인증정보 담아 url 호출)

# install.packages("httr")

library(httr)
# 7. GET 함수 호출
apiResult <- httr::GET(reqURL, 
                       add_headers("X-Naver-Client-Id" = clientID, 
                                   "X-Naver-Client-Secret" = clientPW))

apiResult
# 8. 호출결과 확인
str(apiResult)

apiResult$content

# 9. raw data --> char 변경
blogData <- rawToChar(apiResult$content)

blogData
# 10. encoding 변경
Encoding(blogData) <- "UTF-8"
blogData
CopyData <- gsub("<.*?>", "", blogData) #html 태그 제거
CopyData <- gsub("[[:punct:]]", "", CopyData) #//제거
CopyData <- gsub("[A-z]{1,}", "", CopyData)
CopyData <- gsub("[0-9]{1,}", "", CopyData)


CopyData <- gsub("[ㅎ]{1,}", "", CopyData)
CopyData <- gsub("[ㅜㅜ]{1,}", "", CopyData)
CopyData <- gsub("[ㅋ]{1,}", "", CopyData)
CopyData <- gsub("[♥]{1,}", "", CopyData)
CopyData <- gsub("[▼]{1,}", "", CopyData)
CopyData <- gsub("[발리]{1,}", "", CopyData)
CopyData <- gsub("[여행]{1,}", "", CopyData)
CopyData <- gsub("[가볼]{1,}", "", CopyData)
CopyData
