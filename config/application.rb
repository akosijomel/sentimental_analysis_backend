require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"
require 'rest-client'
require 'indico'
require 'rails/configuration'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SentimentalAnalysisBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    # config.after_initialize do
    #   nyt_url = "https://api.nytimes.com/svc/topstories/v2/home.json?&api-key="
    #
    #   data = JSON.parse( RestClient.get("#{nyt_url}#{ENV["NYT_API_KEY"]}") )
    #
    #   data["results"].each do |article, index|
    #     existing_article = Article.find_by(headline: article["title"])
    #
    #     if existing_article
    #       puts "exists"
    #     else
    #       config = {api_key: "#{ENV["INDICO_API_KEY"]}"}
    #       emotion = (Indico.emotion(article["title"], config))
    #
    #       news = Article.new do |key|
    #         key.headline = article["title"]
    #         key.abstract = article["abstract"]
    #         key.category = article["section"]
    #         key.url = article["url"]
    #         if article["multimedia"].length === 0
    #           key.image = "http://www.nytimes.com/services/mobile/img/ios-newsreader-icon.png"
    #         else
    #           key.image = article["multimedia"][0]["url"]
    #         end
    #         key.anger = emotion["anger"]
    #         key.joy = emotion["joy"]
    #         key.fear = emotion["fear"]
    #         key.sadness = emotion["sadness"]
    #         key.surprise = emotion["surprise"]
    #       end
    #
    #       if news.save
    #         puts "saved"
    #       else
    #         puts "not saved"
    #       end
    #     end
    #   end
    # end
    # config.autoload_paths += Dir["#{Rails.root}/app/lib"]
  end
end
