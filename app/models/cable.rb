class Cable < ApplicationRecord
  validates :headline, uniqueness: true
end
