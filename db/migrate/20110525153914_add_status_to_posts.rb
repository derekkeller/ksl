class AddStatusToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :public, :boolean, :default => true
  end

  def self.down
    remove_column :posts, :public
  end
end
