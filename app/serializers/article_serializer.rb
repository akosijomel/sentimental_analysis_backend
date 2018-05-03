class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :headline, :news_station, :abstract, :category, :url, :image, :anger, :joy, :fear, :sadness, :surprise, :date
end
