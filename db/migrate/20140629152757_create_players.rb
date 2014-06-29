class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.float :balance, default: 100
      t.string :uuid
      t.timestamps
    end
  end
end
