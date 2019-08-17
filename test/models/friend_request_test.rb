require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  def setup
    @sender = users(:james)
    @friend_request = FriendRequest.new(status: 1, sender_id: @sender.id)
  end

  test "receiver should be present" do
    assert_not @friend_request.valid?
  end
end
