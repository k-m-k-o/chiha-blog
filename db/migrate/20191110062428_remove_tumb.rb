class RemoveTumb < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :tumb, :string
    add_column :posts, :thumb, :string, null: false
  end
end
