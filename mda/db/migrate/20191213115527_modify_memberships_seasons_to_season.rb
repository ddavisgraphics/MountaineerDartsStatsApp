class ModifyMembershipsSeasonsToSeason < ActiveRecord::Migration[6.0]
  def change
    remove_reference :memberships, :seasons
    add_reference :memberships, :season, index: true
  end
end
