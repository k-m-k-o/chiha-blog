class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :admin,foreign_key: true
      t.string :title, null: false
      t.text :body,null: false
      t.boolean :posted,null: false
      t.string :category,null: false
      t.timestamps
    end
  end
end
