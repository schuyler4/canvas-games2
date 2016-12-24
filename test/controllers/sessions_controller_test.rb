require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(username: 'helloworld', email: 'joe@poop.com',
    password: '&^*))*())*(*())(*())')

    @user.save
  end

  def test_new
    get login_url
    assert_response :success
  end

  def test_create
    post login_url, params: {email: @user.email, password: @user.password}
    assert_redirected_to root_path
  end

  def test_delete
    delete logout_url
    assert_nil(session[:user_id])
    assert_redirected_to root_path
  end
end
