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
  

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @poster = User.find(@post.user_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @user = current_user
    @post = @user.posts.build
    # @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @user = current_user
    @post = @user.posts.build(params[:post])
    # @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

private
  def set_active_tab
    @classifieds_class = 'current'
    @current_banner = 'header_classifieds'
    @footer_image = 'footer_classifieds'
  end

end
