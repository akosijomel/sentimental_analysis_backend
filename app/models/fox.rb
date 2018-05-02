class Fox < ApplicationRecord
  validates :headline, uniqueness: true
end
