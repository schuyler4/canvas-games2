class AddTitleDescriptionCodeToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :title, :string
    add_column :games, :description, :text
    add_column :games, :code, :text
  end
end
