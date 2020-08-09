install.packages("rvest")

library(ggplot2)
library(rvest)
library(dplyr)
library(stringr)
setwd("C:\\big data class\\R_edu\\rsource\\Rdata\\SSG")

####htmlscrapping####
# 1. url

url_main <- "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=91031&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page="

## 2. html scraping
download.file(url = paste0(url_main, 1, ""),
              destfile = 'bakdu.html', quiet = T)

bakdu_review <- read_html('bakdu.html')
bakdu_review

###3. get data .score_result

star_score <- bakdu_review %>% 
  html_nodes('.score_result') %>% 
  html_nodes('.star_score') %>% 
  html_text()
star_score

star_score1 <- str_replace_all(star_score, "\r|\n|\t", "")
star_score1

###3-2. review

review_text <- bakdu_review %>% html_nodes('.score_result') %>% 
  html_nodes('.score_reple') %>% html_node('p') %>% html_text()
review_text1 <- str_replace_all(review_text, "\r|\n|\t", "")
review_text1


###############################################################################################
url1 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=91031&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page=1"
download.file(url1, destfile = fname, quiet = T)
review_temporary <- read_html(fname)
num <- review_temporary %>% html_nodes('.score_total') %>% 
  html_nodes('strong') %>% html_nodes('em') %>% html_text()
num <- as.numeric(gsub(',',"",num))
page_no <- ceiling(num/10)
star_list <- c()
text_list <- c()
reviewer_list <- c()
date_list <- c()
like_list <- c()
dis_list <- c()
for(page in 1:page_no){
  url <- paste0(url_main, page, "")
  fname <- sprintf('backdu_review(%d).html', page)
  download.file(url, destfile = fname, quiet = T)
  review_temporary <- read_html(fname)
  ##평점
  star_score <- review_temporary %>% html_nodes('.score_result') %>% 
    html_nodes('.star_score') %>% html_text
  star_score1 <- str_replace_all(star_score, "\r|\n|\t", "")
  star_list <- append(star_list, star_score1)
  star_list
  ##리뷰
  text <- review_temporary %>%  html_nodes('.score_result') %>% 
    html_nodes('.score_reple') %>% html_node('p') %>% html_text()
  text1 <- str_replace_all(text, "\r|\n|\t", "")
  text_list <- append(text_list, text1)
  text_list
  ##리뷰어
  reviewer <- review_temporary %>%  html_nodes('.score_result') %>% 
    html_nodes('.score_reple') %>% html_node('dl') %>% html_node('dt') %>% 
    html_node('em') %>% html_node('a') %>% html_text()
  reviewer1 <- str_replace_all(reviewer, "\r|\n|\t", "")
  reviewer_list <- append(reviewer_list, reviewer1)
  reviewer_list
  ##date
  date <- review_temporary %>%  html_nodes('.score_result') %>% 
    html_nodes('.score_reple') %>% html_node('dl') %>% 
    html_node('dt') %>% html_node('em:nth-child(2)') %>% html_text()
  date1 <- str_replace_all(date, "\r|\n|\t", "")
  date_list <- append(date_list, date1)

  ##좋아요
  like <- review_temporary %>%  html_nodes('.score_result') %>% 
    html_nodes('.btn_area') %>% html_node('a') %>% html_text()
  like1 <- str_replace_all(like, "\r|\n|\t|공감", "")
  like_list <- append(like_list, like1)

  ##싫어요
  dis <- review_temporary %>%  html_nodes('.score_result') %>%
    html_nodes('.btn_area') %>% html_node('a._notSympathyButton') %>% html_text()
  dis1 <- str_replace_all(dis, "\r|\n|\t|비공감", "")
  dis_list <- append(dis_list, dis1)
}
Review_df <- data.frame(
  reviewer = reviewer_list,
  score = as.integer(star_list),
  review = text_list,
  like = as.integer(like_list),
  dislike = as.integer(dis_list),
  date = as.POSIXct(date_list, format = "%Y.%m.%d %H:%M")
  #date = date_list
)
View(Review_df)
strptime(date_list[1],"%Y.%m.%d %H:%M")
################################################
plot <- Review_df %>% 
  group_by(score) %>% 
  summarise(mean_dis = mean(dislike))
################################################
ggplot(data = plot, aes(x = score, y = mea
                        n_dis)) + geom_bar()
date_head <- Review_df %>% 
  arrange(date) %>% 
  select(date) %>% 
  head(10)
date_head
x <- Review_df$date
Review_df$date_grade <-
  ifelse(x <= "2013-06-30 23:59:59", "2013 상반기", 
  ifelse(x <= "2013-12-31 23:59:59", "2013 하반기", 
  ifelse(x <= "2014-06-30 23:59:59", "2014 상반기",
  ifelse(x <= "2014-12-31 23:59:59", "2014 하반기",
  ifelse(x <= "2015-06-30 23:59:59", "2015 상반기",
  ifelse(x <= "2015-12-31 23:59:59", "2015 하반기",
  ifelse(x <= "2016-06-30 23:59:59", "2016 상반기",
  ifelse(x <= "2016-12-31 23:59:59", "2016 하반기",
  ifelse(x <= "2017-06-30 23:59:59", "2017 상반기", "2017 하반기 이후")))))))))
plot2 <- Review_df %>% 
  group_by(date_grade) %>% 
  summarise(mean_score = mean(score), num = n())
plot3 <- as.data.frame(plot2)
View(plot2)
ggplot(data = plot3, aes(x = date_grade, y = num)) + geom_bar()

       