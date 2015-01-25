class AddSteamprofileurlToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :steamprofile_url, :string
  end
end
