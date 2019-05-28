class PostsController < ApplicationController
  before_action :set_post, only: [:index]

  def index
    @received_requests = current_user.friend_requests_received.pending
    @posts = current_user.feed
    @comments
    # @comment = @post.comments
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post successfully created!!!"
      redirect_to root_url
    else
      flash[:danger] = "Something prevented post from being created"
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post successfully deleted!!!"
    redirect_to posts_path
  end



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



  private

    def post_params
      params.require(:post).permit(:content)
    end

    def set_post
      if @post = Post.find_by(id: params[:post_id])
        @comments = @post.comments
      end
    end

end
