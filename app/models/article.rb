class Article < ApplicationRecord
  validates :headline, uniqueness: true

  belongs_to :sentiment
end
