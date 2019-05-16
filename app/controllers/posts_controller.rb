class PostsController < ApplicationController

  before_action :require_authorized_user, only: [:destroy]



  def index
    # Not the final implementation
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post successfully created!!!"
      # redirect_back fallback_location: root_path
      redirect_to root_path
    else
      flash[:danger] = "Something prevented post from being created"
      render "new"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post successfully deleted!!!"
    redirect_to posts_path
  end



  private

    def post_params
      params.require(:post).permit(:content)
    end

    def require_authorized_user
      unless @post.user == current_user
        flash[:danger] = "You are not authorized to delete this post"
        redirect_to posts_path
      end
    end

end
