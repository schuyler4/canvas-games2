require 'test_helper'

class GameFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(username: "ben", email:"bengilbert@gmail.com",
      password: "1234")
    @user.save
  end

  def test_game
    login(@user)
    follow_redirect!
    assert_response :success

    get new_user_game_url(@user)
    assert_response :success
    assert_select("h1", "New Game")

    post user_games_url @user, params: {game: {title: "bensGame",
      description: "My first game", code: "console.log('panda')"}}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select("h1", "bensGame")
    assert_select("p", "My first game")
    assert_select("pre", "console.log('panda')")

    @game = Game.last
    get edit_user_game_url(@user, @game)
    assert_response :success

    put user_game_url @user, @game, params: {game: {title: "gamePoop",
      description: "what is life but a game",
      code: "console.log('this is the game of life')"}}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select("h1", "gamePoop")
    assert_select("p", "what is life but a game")
    assert_select("pre", "console.log('this is the game of life')")
  end
end
