# importing libraries and packages
from datetime import datetime
from re import I
from IPython.display import display
import snscrape.modules.twitter as sntwitter
import pandas as pd
import csv

# for timing execution
begin_time = datetime.now()

# list to hold tweets scraped
tweets_list1 = []

# variables to be scraped for
term = 'jew'
city = "New York City"
# state = '"NY"'

# scraping within 30 mi of each city in the locations_stripped list
for i, tweet in enumerate(sntwitter.TwitterSearchScraper(term + ' since:2017-01-01 until:2020-12-31 near:"New York City, NY" within:30mi').get_items()):
    if i > 9:
        break
    tweets_list1.append([tweet.date, tweet.id, tweet.content, tweet.user.username,
                         tweet.user.location, tweet.lang, tweet.place])
    print(i)

tweets_df1 = pd.DataFrame(tweets_list1, columns=[
                          'Datetime', 'ID', 'Text', 'Username', 'Location', 'Language', 'Place'])
display(tweets_df1)

tweets_df1.to_csv(r'~/ia440/test_scrape_11-29.csv')

# calculating execution time
print("execution time", datetime.now() - begin_time)
