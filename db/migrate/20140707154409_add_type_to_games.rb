class AddTypeToGames < ActiveRecord::Migration
  def up
    add_column :games, :type, :string
  end

  def down
    remove_column :games, :type
  end
end
