class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:update, :destroy]


  def index
    @sent_requests = current_user.friend_requests_sent.pending
    @received_requests = current_user.friend_requests_received.pending
  end

  def create
    @friend_request = FriendRequest.find_or_initialize_by(sender_id: current_user.id, receiver_id: params[:friend_request][:receiver_id])
    @friend_request.status = 0

    if @friend_request.save
      flash[:success] = "Friend request sent"
    else
      flash[:danger] = "Something went wrong: friend request not sent"
    end
    redirect_to users_path

  end

  def update
    # @friend_request.accept
      if @friend_request.update(status: 1)
        @friend_request.sender.establish_friendship(@friend_request.receiver)
        flash[:success]= "You're now friend with #{@friend_request.sender.first_name}"
      else
        flash[:danger] = "Something went wrong"
      end
      redirect_to root_path
  end

  def decline
    @frined_request.destroy
    flash[:success]="You declined a friend request"

  end

  def destroy
    @friend_request.destroy
    redirect_to friend_requests_url
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

end
