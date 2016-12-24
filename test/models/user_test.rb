require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "panda", email: "panda@gmail.com",
      password_digest: "123panda")
    @user2 = User.new(username: "panda123", email: "panda123@gmail.com",
     password_digest: "123panda")
    @user.save
  end

  def test_user
    assert @user.valid?
  end

  def test_username
    @user.username = ''
    assert_not @user.valid?
  end

  def test_email
    @user.email = ''
    assert_not @user.valid?
  end

  def test_password
    @user.password_digest = ''
    assert_not @user.valid?
  end

  def test_repeat
    @user2.email = "panda@gmail.com"
    assert_not @user2.valid?
  end
end
