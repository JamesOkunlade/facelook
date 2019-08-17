class CommentsController < ApplicationController


  def post_comments
    respond_to do |format|
      if @post = Post.find_by(id: params[:post_id])
        @comments = @post.comments
        format.html { redirect_to @post }
        format.js
      else
        format.html { redirect_back fallback_location: root_path, danger: "Something went wrong!" }
        format.js
      end
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment successfully added!!!"
      redirect_to root_path
    else
      flash[:danger] = "Something prevented comment from being created"
      redirect_to root_path
    end
  end

  def destroy

  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end

end
