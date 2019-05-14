require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(first_name: "Lade", last_name: " ")
  end

  test "Should be valid" do
    assert_not @user.valid?
  end

end
