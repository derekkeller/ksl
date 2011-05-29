class PostsController < ApplicationController

  load_and_authorize_resource
  before_filter :set_active_tab

  def index  
    if current_user.present?
      if current_user.admin?
        @posts = Post.all(:order => "created_at DESC")
      else current_user.manager?
        @posts = Post.where('public = 1 OR user_id = ?', current_user.id).all(:order => "created_at DESC")
      end
    end
    @posts = Post.where(:public => true).all(:order => "created_at DESC")
  end
  
  def post_search
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @posts = Post.where("category_id = ?", @category)
    end
    render :update do |page|
      page.replace_html :posts_data, :partial => 'posts'
      page.replace_html :category_id, @category.name
    end
  end
  
  def show
    @category = Category.find(params[:category_id])
    @post = @category.posts.find(params[:id])
    @poster = User.find(@post.user_id)
  end

  def new
    @category = Category.find(params[:category_id])
    @post = @category.posts.new
  end

  def edit
    @category = Category.find(params[:category_id])
    @post = @category.posts.find(params[:id])
  end

  def create
    @category = Category.find(params[:category_id])
    @post = @category.posts.new(params[:post].merge(:user_id => current_user.id))
    @post.user_id = current_user.id

    if @post.save
      redirect_to categories_path, :notice => 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:category_id])
    @post = @category.posts.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to categories_path, :notice => 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to categories_path
  end

private
  def set_active_tab
    @classifieds_class = 'current'
    @current_banner = 'header_classifieds'
    @footer_image = 'footer_classifieds'
  end

end
