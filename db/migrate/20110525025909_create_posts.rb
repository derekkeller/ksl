class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string  :title
      t.float   :price
      t.text    :description
      t.string  :list_name
      t.string  :list_email
      t.string  :city
      t.string  :state
      t.integer :zipcode
      t.string  :type
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
