class FriendshipsController < ApplicationController

  def destroy
    user = User.find_by(id: params[:user_id])
    current_user.destroy_friendship(user)
    flash[:success] = "Succesfuly destroyed friendship"
    redirect_back(fallback_location: root_path)
  end

end
