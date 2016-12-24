require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get signup_url
    assert_response :success
  end

  def test_create
    assert_difference('User.count') do
      post users_url, params: {user: {
        username: 'bobowaffle',
        email: 'bobowaffle@gmail.com',
        password: '1234'
      }}
    end

    @user = User.find_by_email('bobowaffle@gmail.com')

    assert_equal(session[:user_id], @user.id)
    assert_redirected_to user_path(@user)
  end
end
