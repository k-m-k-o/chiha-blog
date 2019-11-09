class Remove < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts,:posted, :boolean
    add_column :posts, :posted ,:boolean ,null: false,default: false
  end
end
