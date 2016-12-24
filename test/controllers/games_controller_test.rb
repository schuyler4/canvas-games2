require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(username: 'awsomeMe', email: 'awsomeMe@gmail.com',
    password: 'awawKFDKASAASSuuu')
    @user.save
    login(@user)

    @game = Game.new(title: 'fdas', description: 'fasf', code: 'fasdfasdf')
    @game.save
  end

  def test_index
    get games_url
    assert_response :success
  end

  def test_new
    get new_user_game_url(@user)
    assert_response :success
  end

  def test_edit
    get edit_game_url(@user, @game)
    assert_response :success
  end

  def test_show
    get user_game_url(@game.user, @game)
    assert_response :success
  end

  def test_create
    assert_difference('Game.count') do
      post games_url, params: {game:
        {title: 'game', description: 'a game', code: '//game'}}
    end

    assert_redirected_to root_path
  end

  def test_update
    patch game_url(@game), params: {game:
      {title: 'some game', description: 'some game', code: '//some game'}}

    assert_redirected_to root_path
    assert @game.title, 'some game'
  end

  def test_delete
    assert_difference('-Game.count') do
      delete game_url(@game)
    end

    assert_redirected_to root_path
  end
end
