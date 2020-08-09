library(dplyr)
library(ggplot2)
library(stringr)

setwd("C:\\big data class\\R_edu\\rsource\\Rdata")


movies <-  readLines(con= 'movies.dat')
ratings <-  readLines(con= 'ratings.dat')
users <-  readLines(con= 'users.dat')
#####################################################################
movies_new <- gsub("::",";",movies)
ratings_new <- gsub("::",";",ratings)
users_new <- gsub("::",";",users)
#####################################################################
movie_new <- read.csv(text = movies_new, sep = ';', header = FALSE, fill = TRUE)
rating_new <- read.csv(text = ratings_new, sep = ';', header = FALSE, fill = TRUE)
user_new <- read.csv(text = users_new, sep = ';', header = FALSE, fill = TRUE)
movie_new
#####################################################################

movie_zzin <- rename(movie_new, movie_id = V1, title = V2, genres = V3)
rating_zzin <- rename(rating_new, user_id = V1, movie_id = V2, rating = V3, time_stamp = V4)
user_zzin <- rename(user_new, user_id = V1, gender = V2, age = V3, occupation = V4, zip_code = V5)
table(is.na(movie_zzin))
table(is.na(user_zzin))
table(is.na(rating_zzin))
#welfare <- left_join(welfare, list_job, id = "code_job")

movie_ggin <- movie_zzin %>% select(movie_id, title, genres)
rating_ggin <- rating_zzin %>% select(user_id, movie_id, rating)
user_ggin <- user_zzin %>% select(user_id, gender)

rating_user <- left_join(rating_ggin, user_ggin, id = "user_id")
table(is.na(rating_user))

movie_ggin$movie_id <- as.integer(movie_ggin$movie_id)
movie_rating_user <- left_join(movie_ggin, rating_user, id = "movie_id")
head(movie_rating_user, 100)
View(movie_rating_user)
table(is.na(movie_rating_user$gender))
movie_rating_user %>% 
  filter(is.na(movie_rating_user$rating)) %>% 
  head(20)
###2-1
movie_rating_user_tr <- movie_rating_user %>%
  filter(!is.na(movie_id) & !is.na(gender)) %>% 
  group_by(movie_id, title, gender) %>% 
  summarise(mean_rating = mean(rating)) %>% 
  arrange(movie_id)
View(movie_rating_user_tr)

install.packages('reshape')
library(reshape)
cc <- cast(movie_rating_user_tr, title~gender, value = 'mean_rating')
cc %>% head(4)

###2-2
female_best <- movie_rating_user %>%
  filter(!is.na(movie_id) & !is.na(gender) & gender == 'F') %>% 
  group_by(movie_id, title, gender) %>% 
  summarise(mean_rating = mean(rating), num = n()) %>% 
  filter(num >= 100) %>% 
  arrange(desc(mean_rating)) %>% 
  head(50)
View(female_best)

###2-3 남녀 인기장르를 찾아보자!
genre_best <- movie_rating_user %>%
  filter(!is.na(gender)) %>%
  select(gender, genres, rating) %>% 
  group_by(gender, genres) %>% 
  summarise(mean_rating = mean(rating)) %>% 
  arrange(desc(mean_rating)) %>% 
  head(10)
genre_best
ggplot(data = genre_best, aes(x = genres, y = mean_rating, fill = gender)) + #막대 안에 막대!
  geom_col(position = "dodge")#밖으로 튀어나오게!

###2-4장르 분석 고고
movie_genres <- movie_ggin %>% select(genres)
genre_vec <- unlist(str_extract_all(movie_genres, '[A-z$]{2,}'))
genre_vec <- gsub("Sci", "Sci-Fi", genre_vec)
genre_vec <- gsub("Fi", NA, genre_vec)
genre_vec <- genre_vec[!is.na(genre_vec)]
genre_vec <- unique(genre_vec)
View(genre_vec)
movie_ggin[1,3]

####
movie_ggin$genre1 <- c(NA)
movie_ggin$genre2 <- c(NA)
movie_ggin$genre3 <- c(NA)
movie_ggin[40,5]
for (i in 1:length(movie_ggin$genres)){
  genre_vec_m <- c(unlist(str_extract_all(movie_ggin[i,3], '[A-z$]{2,}')))
  ifelse(length(genre_vec_m) == 0, TRUE,
         for (j in 1:length(genre_vec_m)){
        movie_ggin[i, j+3] <- genre_vec_m[j]
         })
  genre_vec_m <- c(NA, NA, NA)
}
genre_vec_m <- unlist(str_extract_all(movie_ggin[700,3], '[A-z$]{2,}'))
genre_vec_m
View(movie_ggin)
