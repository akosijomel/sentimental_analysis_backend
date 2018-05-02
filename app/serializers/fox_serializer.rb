class FoxSerializer < ActiveModel::Serializer
  attributes :id, :headline, :abstract, :url, :image, :anger, :joy, :fear, :sadness, :surprise, :date
end
