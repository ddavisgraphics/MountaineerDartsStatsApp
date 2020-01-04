class Match < ApplicationRecord
  belongs_to :season
  serialize :results, HashWithIndifferentAccess
  store_accessor :results, :away, :home
end
