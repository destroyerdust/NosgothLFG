class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :avatarurl
      t.string :nickname
      t.string :steamid
      t.string :vampire
      t.string :human
      t.text :comment

      t.timestamps
    end
  end
end
