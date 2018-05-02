class American < ApplicationRecord
  validates :headline, uniqueness: true
end
