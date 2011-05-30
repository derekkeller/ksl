class Category < ActiveRecord::Base

  belongs_to :user
  has_many :posts, :dependent => :nullify
  
  def Post.search(x)
    if x
      where('title LIKE ?', "%#{x}%")
    else
      all
    end
  end

end
