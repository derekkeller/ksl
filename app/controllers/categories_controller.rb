class CategoriesController < ApplicationController

  before_filter :set_active_tab
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def show
    @all_posts = Post.all
    @category = Category.find(params[:id])
    @posts = @category.posts
  end

  def new
    @category = Category.new
    @categories = Category.all
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to @category, :notice => 'Category created'
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to @category
    else
      render :new
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to :categories
  end


  def all_posts
    @posts = Post.all(:order => "created_at DESC")
  end

  private
    def set_active_tab
      @classifieds_class = 'current'
      @current_banner = 'header_classifieds'
      @footer_image = 'footer_classifieds'
    end

end
