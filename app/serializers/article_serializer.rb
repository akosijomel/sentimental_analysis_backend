class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :headline, :abstract, :category, :url, :image, :anger, :joy, :fear, :sadness, :surprise
end
