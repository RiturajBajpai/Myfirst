#https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/

library(rvest)
url<-'https://www.imdb.com/search/title/?count=100&release_date=2016,2016&title_type=feature'
webpage<-read_html(url)
#scrapping rankings
rank_html<-html_nodes(webpage,'.text-primary')
#storing ranking as text
rank_data<-html_text(rank_html)
#converting ranking to numeric format
rank_data<-as.numeric(rank_data)

#scrapping titles
title_html<-html_nodes(webpage,'.lister-item-header a')
#transforming as text
title_data<-html_text(title_html)
title_data<-trimws(title_data)

#scrapping rating and converting
rating_data<-as.numeric(html_text(html_nodes(webpage,'.ratings-imdb-rating strong')))
head(rating_data)

#scrapping genre
genre_data<-html_text(html_nodes(webpage,'.genre'))
#cleaning data
genre_data<-trimws(gsub(',.*','',gsub('\n','',genre_data)))


#creating datatframe
movies.df<-data.frame(Rank=rank_data,Movie=title_data,Genre=genre_data)
head(movies.df)
