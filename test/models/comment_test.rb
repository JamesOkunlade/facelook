require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:james)
    @post = posts(:one)
    @comment = Comment.new(content: "Okay this is comment", user_id: @user.id, post_id: @post.id)

  end

  test "should be valid" do
    assert @comment.valid?
  end


end
