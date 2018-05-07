require 'rest-client'
require 'indico'
require 'rails/configuration'


  fox_url = "https://newsapi.org/v2/top-headlines?sources=fox-news&apiKey="

  data = JSON.parse( RestClient.get("#{fox_url}#{ENV["NEWS_API_KEY"]}") )


  data["articles"].each do |article, index|
    existing_article = Article.find_by(headline: article["title"])
    if article["description"].length > 0
      if !existing_article
        config = {api_key: "#{ENV["INDICO_API_KEY"]}"}
        emotion = (Indico.emotion(article["description"], config))

        news = Article.new do |key|
          key.headline = article["title"]
          key.news_station = "Fox News"
          key.abstract = article["description"]
          key.url = article["url"]
          if article["urlToImage"] === nil
            key.image = "http://global.fncstatic.com/static/v/all/static-page/apps-products/img/fn-logo.png"
          elsif article["urlToImage"] === ActiveRecord::RecordNotFound
            key.image = "http://global.fncstatic.com/static/v/all/static-page/apps-products/img/fn-logo.png"
          else
            key.image = article["urlToImage"]
          end
          key.anger = emotion["anger"]
          key.joy = emotion["joy"]
          key.fear = emotion["fear"]
          key.sadness = emotion["sadness"]
          key.surprise = emotion["surprise"]
          key.date = Time.now
        end
        if news.save
          puts "saved fox"
        else
          puts "not saved fox"
        end
      end
    end
  end
