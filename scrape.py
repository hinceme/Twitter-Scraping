# importing libraries and packages
from datetime import datetime
from IPython.display import display
import snscrape.modules.twitter as sntwitter
import pandas as pd
import csv
import sys

# for timing execution
begin_time = datetime.now()

# list to hold scraped tweets
tweets_list = []

# reading city,state from script input
# argv[1] should be city csv
locations = []
with open(sys.argv[1]) as csvfile:
    for line in csvfile:
        locations.append(line)

# splitting on commas and saving in locations_stripped list
locations_stripped = []
for i in range(len(locations)):
    temp = locations[i].rstrip(",\n")
    locations_stripped.append(temp)

# terms to be scraped for
# argv[2] should be terms csv
terms = ['jew', 'joo', '(((', ')))', 'Rothschild', 'George Soros', 'New World Order', 'goyim', 'Holocaust', 'holahoax', 'holohoax', 'Shoah']

# scraping within 30 mi of each city in the locations_stripped list
for i in range(len(locations_stripped)):
	for j in range(len(terms)):
		print(locations_stripped[i], terms[j])
		for k, tweet in enumerate(sntwitter.TwitterSearchScraper(terms[j] + ' since:2017-01-01 until:2020-12-31 near:' + "\"" + locations_stripped[i] + "\"" + 'within:30mi').get_items()):
			if k > 100:
				break
			tweets_list.append([tweet.id, tweet.date, tweet.content, tweet.user.username, tweet.user.location, tweet.lang, tweet.place])

tweets_df = pd.DataFrame(tweets_list, columns=['ID', 'Datetime', 'Text', 'Username', 'Location', 'Language', 'Place'])
display(tweets_df)
tweets_df.to_csv(r'~/ia440/test_02_15_2022.csv');
   
# calculating execution time
print("execution time", datetime.now() - begin_time)
