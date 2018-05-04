require 'rest-client'
require 'indico'
require 'rails/configuration'


  nyt_url = "https://api.nytimes.com/svc/topstories/v2/home.json?&api-key="

  data = JSON.parse( RestClient.get("#{nyt_url}#{ENV["NYT_API_KEY"]}") )


  data["results"].each do |article, index|
    existing_article = Article.find_by(headline: article["title"])
    if article["abstract"].length > 0
      if !existing_article
        config = {api_key: "#{ENV["INDICO_API_KEY"]}"}
        emotion = (Indico.emotion(article["abstract"], config))

        news = Article.new do |key|
          key.headline = article["title"]
          key.news_station = "New York Times"
          key.abstract = article["abstract"]
          key.category = article["section"]
          key.url = article["url"]
          if article["multimedia"].length === 0
            key.image = "http://www.nytimes.com/services/mobile/img/ios-newsreader-icon.png"
          else
            key.image = article["multimedia"][0]["url"]
          end
          key.anger = emotion["anger"]
          key.joy = emotion["joy"]
          key.fear = emotion["fear"]
          key.sadness = emotion["sadness"]
          key.surprise = emotion["surprise"]
          key.date = Time.now
        end
        if news.save
          puts "saved nyt"
        else
          puts "not saved"
        end
      end
    end
  end
