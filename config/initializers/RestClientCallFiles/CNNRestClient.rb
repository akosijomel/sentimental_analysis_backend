require 'rest-client'
require 'indico'
require 'rails/configuration'


  cnn_url = "https://newsapi.org/v2/top-headlines?sources=cnn&apiKey="

  data = JSON.parse( RestClient.get("#{cnn_url}#{ENV["NEWS_API_KEY"]}") )


  data["articles"].each do |article, index|
    existing_article = Article.find_by(headline: article["title"])
    if article["description"].length > 0
      if !existing_article
        config = {api_key: "#{ENV["INDICO_API_KEY"]}"}
        emotion = (Indico.emotion(article["description"], config))

        news = Article.new do |key|
          key.headline = article["title"]
          key.news_station = "Cable News Network"
          key.abstract = article["description"]
          key.url = article["url"]
          if article["urlToImage"] === nil
            key.image = "https://yt3.ggpht.com/a-/AJLlDp0ZdRWMgQ0r70gOBmYQd6dM8xcUhipQvQt_Gw=s900-mo-c-c0xffffffff-rj-k-no"
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
          puts "saved cnn"
        else
          puts "not saved cnn"
        end
      end
    end
  end
