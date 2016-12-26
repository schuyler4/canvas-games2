require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def test_user
    get signup_url
    assert_response :success

    post users_url params: {user:
      {username: "jack", email: "jacklendon@gamil.com", password: "panda"}}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select("h1", "jack")

    delete logout_url
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select("h1", "Top Rated Games")

    get login_url
    assert_response :success
    assert_select("h1", "Login")

    post login_url params: {email: "jacklendon@gamil.com", password: "panda"}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select("h1", "jack")
  end
end
