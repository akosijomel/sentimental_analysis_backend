class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :headline, :abstract, :category, :url, :image
  belongs_to :sentiment
end
