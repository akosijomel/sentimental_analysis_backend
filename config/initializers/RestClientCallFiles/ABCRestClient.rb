require 'rest-client'
require 'indico'
require 'rails/configuration'


  abc_url = "https://newsapi.org/v2/top-headlines?sources=abc-news&apiKey="

  data = JSON.parse( RestClient.get("#{abc_url}#{ENV["NEWS_API_KEY"]}") )


  data["articles"].each do |article, index|
    existing_article = Article.find_by(headline: article["title"])
    if article["description"]
      if !existing_article
        config = {api_key: "#{ENV["INDICO_API_KEY"]}"}
        emotion = (Indico.emotion(article["description"], config))

        news = Article.new do |key|
          key.headline = article["title"]
          key.news_station = "American Broadcasting Corporation"
          key.abstract = article["description"]
          key.url = article["url"]
          if article["urlToImage"] === nil
            key.image = "https://is5-ssl.mzstatic.com/image/thumb/Purple128/v4/e3/5b/08/e35b0864-bcae-517c-b2b0-d5481996818a/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-4.png/1200x630bb.jpg"
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
          puts "saved abc"
        else
          puts "not saved abc"
        end
      end
    end
  end
