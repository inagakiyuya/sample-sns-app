class PostsController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @posts = @q.result(distinct: true).
             includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post), success: "投稿の作成に成功しました。"
    else
      flash.now[:danger] = "投稿の作成に失敗しました。"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
  end

  def edit
    @post = current_user.posts.new(post_params)
  end

  def update
    @post = current_user.posts.new(post_params)
    if @post.update(post_params)
      redirect_to post_path(@post), success: "投稿の編集に成功しました。"
    else
      flash.now[:danger] = "投稿の編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.new(post_params)
    @post.destroy
    redirect_to posts_path, success: "投稿の削除に成功しました。"
  end

  private
    
  def post_params
    params.require(:post).permit(:title, :post_content)
  end
end
