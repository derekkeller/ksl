class CategoriesController < ApplicationController

  def show
    @posts = Post.find(params[:id])
    @category = @posts 
  end

  def appliances
    @posts = Post.where("category_id = ?", 1)
  end

  def books_and_media
    @posts = Post.where("category_id = ?", 2)
  end

  def clothing
    @posts = Post.where("category_id = ?", 3)
  end

  def computers
    @posts = Post.where("category_id = ?", 4)
  end

  def electronics
    @posts = Post.where("category_id = ?", 5)
  end

  def furniture
    @posts = Post.where("category_id = ?", 6)
  end

  def general
    @posts = Post.where("category_id = ?", 7)
  end

  def homes
    @posts = Post.where("category_id = ?", 8)
  end

  def recreational_vehicles
    @posts = Post.where("category_id = ?", 9)
  end

end
