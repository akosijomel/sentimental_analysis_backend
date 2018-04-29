class SentimentSerializer < ActiveModel::Serializer
  attributes :id, :anger, :joy, :fear, :sadness, :surprise
  has_many :articles
end
