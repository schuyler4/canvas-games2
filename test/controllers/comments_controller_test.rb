require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(username: "bigelaphant", email: "elaphant@email.com",
      password: "elaphants_for_life")
    @user.save

    login(@user)

    @game = Game.new(title: "bigOlGame", description: "more funer",code: 'fsad')
    @game.user = @user
    @game.save
  end

  def test_page
    get user_game_url(@game.user, @game)
    assert_response :success
  end

  def test_create
    context = {comment: {body: "not finished yet"}}

    assert_difference('Comment.count') do
      post user_game_comments_path @user, @game, params: context
    end

    assert_redirected_to user_game_path(@game.user, @game)
    assert_equal(Comment.last.body, "not finished yet")
  end

  def test_update
    @comment = Comment.first
    @user = @comment.user
    @game = @comment.game

    put user_game_comment_path @user, @game, @comment, params:
      {body: "the new body"}

    assert_redirected_to user_game_path(@user, @game)
  end

  def test_destroy
    @comment = Comment.last

    assert_difference('-Comment.count') do
      delete user_game_comment_path(@user, @game, @comment)
    end

    assert_redirected_to user_game_path(@game.user, @game)
  end
end
