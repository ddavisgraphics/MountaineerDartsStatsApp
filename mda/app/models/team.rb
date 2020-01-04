class Team < ApplicationRecord
  belongs_to :division

  has_many :memberships
  has_many :players, through: :memberships
  accepts_nested_attributes_for :memberships
  has_many :seasons, through: :memberships

  has_one :captain_membership, -> { where captain: true }, class_name: 'Membership'
  has_one :captain, through: :captain_membership, source: :player
end
