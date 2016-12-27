require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(username: "bigelaphant", email: "elaphant@email.com",
      password: "elaphants_for_life")
    @user.save

    login(@user)

    @game = @user.games.new(title: "bigOlGame", description: "more funer",code: 'fsad')
    @game.save

    @comment = @user.comments.new(body: "cool game")
    @comment.game = @game
    @comment.save
  end

  def test_page
    puts @user.games.first.comments.all

    get user_game_url(@user.games.first, @game)
    assert_response :success
  end

  def test_create
    context = {comment: {body: "not finished yet"}}

    assert_difference('Comment.count') do
      post user_game_comments_path @user, @game, params: context
    end

    assert_redirected_to user_game_path(@game.user, @game)
    assert_equal(Comment.last.body, "not finished yet")
    assert_not_equal @user.games.all, []
    assert_not_nil @user.comments.last
  end

  def test_update
    skip
    @comment = @user.comments.first
    assert_not_nil @comment

    #put user_game_comment_path @user, @comment, @comment, params:
    #  {body: "the new body"}

    #assert_redirected_to user_game_path(@user, @game)
  end

  def test_destroy
    skip
    @comment = @user.comments.last

    assert_difference('-Comment.count') do
      delete user_game_comment_path(@user, @game, @comment)
    end

    assert_redirected_to user_game_path(@game.user, @game)
  end
end
