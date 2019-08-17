require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:james)
    @post = posts(:one)
    @like = Like.new(user_id: @user.id, post_id: @post.id)
  end

  test "should be valid" do
    assert @like.valid?
  end
end
