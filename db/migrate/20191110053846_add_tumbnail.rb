class AddTumbnail < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :tumb, :string, null: false
  end
end
