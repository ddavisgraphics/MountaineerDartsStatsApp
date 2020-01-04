class Season < ApplicationRecord
  has_many :matches, dependent: :destroy
end
