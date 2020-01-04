class Accolaid < ApplicationRecord
  belongs_to :season
  belongs_to :player

  enum accolaid: { T80: 0, T71: 1, T70: 2, high_in: 3, high_out: 4, ron: 5, high_average: 6 }
end
