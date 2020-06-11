# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  def post_comments
    if @post = Post.find_by(id: params[:post_id])
      @comments = @post.comments
      # @comments = @post.comments.paginate(page: params[:page], per_page: 3)
    end

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'Comment successfully added!!!'
    else
      flash[:danger] = 'Something prevented comment from being created'
    end
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
