class Broadcasting < ApplicationRecord
  validates :headline, uniqueness: true
end
