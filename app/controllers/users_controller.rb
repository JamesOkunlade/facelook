class UsersController < ApplicationController

  before_action :set_user, only: [:show, :friends]
  before_action :set_current_user, only: [:me, :edit]


  def index
    friends               = current_user.friends.ids
    sent_request_to       = current_user.friend_requests_sent.pending.pluck(:receiver_id)
    received_request_from = current_user.friend_requests_received.pending.pluck(:sender_id)
    friend_or_has_pending_request = friends + [current_user.id] + sent_request_to + received_request_from
    @users = User.all.where.not("id IN (?)", friend_or_has_pending_request)
  end

  def show
    @posts = @user.posts
    # @comment = @post.comments
  end
  
  def friends

  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end

end
