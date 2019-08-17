class PostsController < ApplicationController
  before_action :set_post, only: [:index]

  def index
    @received_requests = current_user.friend_requests_received.pending
    @posts = current_user.feed
    @comments
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


  private


    def post_comments
      @post = Post.find_by(id: params[:post_id])
      @comments = @post.comments
    end

    def post_params
      params.require(:post).permit(:content)
    end

    def set_post
      if @post = Post.find_by(id: params[:post_id])
        @comments = @post.comments
      end
    end

end
