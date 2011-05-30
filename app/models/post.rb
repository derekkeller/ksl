class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  
  validates :category_id, :presence => true

  def self.search(x)
    if x
      where('title LIKE ?', "%#{x}%")
    else
      all
    end
  end

  def self.category_search(x)
    if x
      where('category_id LIKE ?', "#{x}")
    else
      all
    end
  end

end
