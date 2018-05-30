require 'rest-client'
require 'indico'
require 'rails/configuration'

  #New York Times API endpoint
  nyt_url = "https://api.nytimes.com/svc/topstories/v2/home.json?&api-key="

  #RestClient get request to the NYT endpoint with my API Key being parsed into a JS object
  data = JSON.parse( RestClient.get("#{nyt_url}#{ENV["NYT_API_KEY"]}") )

  #Iterating through each result/article of the NYT
  data["results"].each do |article, index|
    #finding existing articles
    existing_article = Article.find_by(headline: article["title"])
    #checking if the articles abstract is there and if the article doesnt exist
    if article["abstract"].length > 0
      if !existing_article
        config = {api_key: "#{ENV["INDICO_API_KEY"]}"}
        #Running sentimental analysis on the article's abstract
        emotion = (Indico.emotion(article["title"], config))

        #Creating a new article in my database and assigning it's properties
        news = Article.new do |key|
          key.headline = article["title"]
          key.news_station = "New York Times"
          key.abstract = article["abstract"]
          key.category = article["section"]
          key.url = article["url"]
          #Some of the articles didnt have pictures so I made a default one if there was no pic
          if article["multimedia"].length === 0
            key.image = "http://www.nytimes.com/services/mobile/img/ios-newsreader-icon.png"
          else
            key.image = article["multimedia"][0]["url"]
          end
          #Saving sentiments
          key.anger = emotion["anger"]
          key.joy = emotion["joy"]
          key.fear = emotion["fear"]
          key.sadness = emotion["sadness"]
          key.surprise = emotion["surprise"]
          key.date = Time.now
        end
        #Saving articles
        if news.save
          puts "saved nyt"
        else
          puts "not saved"
        end
      end
    end
  end
