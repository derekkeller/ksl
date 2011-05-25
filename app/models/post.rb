class Post < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :categories

  # attr_accessible :post_type, :category_id

end
