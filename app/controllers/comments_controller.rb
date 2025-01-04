class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_path (@comment.post_id), success: "コメントを作成しました。"
    else
      @post = @comment.post
      flash.now[:danger] = "コメントを作成できませんでした。"
      render 'posts/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!

    redirect_to post_path(@post), success: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, post_id)
  end
end
