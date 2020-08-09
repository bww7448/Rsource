dic <- readLines(con = "seo_bus_res2.txt", encoding = "UTF-8")
View(dic)
write.csv(dic, "ula3.csv")

new_dic <- read.csv(file = "ula3.csv", sep = '|', quote = "",
                    header = FALSE, row.names = NULL, fill = TRUE)
dic[2]
View(new_dic)
View(new_dic)
new_dic <- gsub("|", ";", new_dic)
new_dic2 <- read.csv(text = new_dic, sep = ';', header = FALSE, fill = TRUE)
KoNLP::buildDictionary()
buildDictionary( user_dic = new_dic2,
  replace_usr_dic = TRUE)
