require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @adder = users(:james)
    @friendship = Friendship.new(adder_id: @adder.id)
  end

  test "receiver should be present" do
    assert_not @friendship.valid?
  end
end
