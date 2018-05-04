require 'rest-client'
require 'indico'
require 'rails/configuration'


  bbc_url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey="

  data = JSON.parse( RestClient.get("#{bbc_url}#{ENV["NEWS_API_KEY"]}") )


  data["articles"].each do |article, index|
    existing_article = Article.find_by(headline: article["title"])
    if article["description"].length > 0
      if !existing_article
        config = {api_key: "#{ENV["INDICO_API_KEY"]}"}
        emotion = (Indico.emotion(article["description"], config))

        news = Article.new do |key|
          key.headline = article["title"]
          key.news_station = "British Broadcasting Corporation"
          key.abstract = article["description"]
          key.url = article["url"]
          if article["urlToImage"] === nil
            key.image = "https://pmcdeadline2.files.wordpress.com/2016/06/bbc-logo.jpg?w=446&h=299&crop=1"
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
          puts "saved bbc"
        else
          puts "not saved bbc"
        end
      end
    end
  end
