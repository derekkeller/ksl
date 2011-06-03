class PostsController < ApplicationController

  load_and_authorize_resource
  before_filter :set_active_tab

  def index  
    if current_user.present?
      if current_user.admin?
        
        if params[:my_search]
          @posts = Post.search(params[:my_search]).order('created_at DESC')
        elsif params[:category_search]
          @posts = Post.category_search(params[:category_search])
        else
          @posts = Post.order('created_at DESC').all
        end
      else current_user.manager?
        @posts = Post.where('public = 1 OR user_id = ?', current_user.id).all(:order => "created_at DESC")
      end
    end
    if params[:my_search]
      @posts = Post.search(params[:my_search]).where(:public => true).all(:order => "created_at DESC")
    elsif params[:category_search]
      @posts = Post.category_search(params[:category_search]).where(:public => true).all(:order => "created_at DESC")
    else
      @posts = Post.where(:public => true).all(:order => "created_at DESC")
    end
  end

  def show
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @post = @category.posts.find(params[:id])
      @poster = User.find(@post.user_id)
    else
      @category = Post.find(params[:id]).category
      @post = Post.find(params[:id])
      @poster = User.find(@post.user_id)
    end
  end

  def new
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @post = @category.posts.new
    else
      @post = Post.new
    end
  end

  def create
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @post = @category.posts.new(params[:post].merge(:user_id => current_user.id))
      @post.user_id = current_user.id
    else
      @post = Post.new(params[:post].merge(:user_id => current_user.id))
      @post.user_id = current_user.id
    end

    if @post.save
      if params[:category_id]
        redirect_to category_post_path(@category, @post), :notice => 'Post was successfully created.'
      else
        redirect_to @post
      end
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @category = @post.category
  end

  def update
    @category = Category.find(params[:category_id])
    @post = @category.posts.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to category_post_path(@category, @post), :notice => 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @category = @post.category_id
    @post.destroy
    if @category.present?
      redirect_to category_path(@category)
    else
      redirect_to posts_path
    end
  end

  # def destroy
  #   @category = Category.find(params[:category_id])
  #   @post = @category.posts.find(params[:id])
  #   @post.destroy
  #   redirect_to @category
  # end

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

private
  def set_active_tab
    @classifieds_class = 'current'
    @current_banner = 'header_classifieds'
    @footer_image = 'footer_classifieds'
  end

end
