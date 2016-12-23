require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @game = Game.new(title: 'fdas', description: 'fasf', code: 'fasdfasdf')
    @game.save
  end

  def test_index
    get games_url
    assert_response :success
  end

  def test_new
    get new_game_url
    assert_response :success
  end

  def test_edit
    get edit_game_url(@game.id)
    assert_response :success
  end

  def test_show
    get game_url(@game.id)
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
    patch game_url(@game.id), params: {game:
      {title: 'some game', description: 'some game', code: '//some game'}}

    assert_redirected_to root_path
    assert @game.title, 'some game'
  end

  def test_delete
    assert_difference('-Game.count') do
      delete game_url(@game.id)
    end

    assert_redirected_to root_path
  end
end
