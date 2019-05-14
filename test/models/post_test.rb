require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:james)
    @post = Post.new(content: "This is a test content", user_id: @user.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

end
