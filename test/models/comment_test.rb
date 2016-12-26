require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "len", email:"lengilbert@gmail.com",
      password: "1234")
    @user.save

    @game = Game.new(title: "d", description: "d", code: "hello there")
    @game.save

    @comment = Comment.new(user: @user, game: @game, body: "awsome man")
  end

  def test_all_valid
    assert @comment.valid?
  end

  def test_body
    @comment.body = ''
    assert_not @comment.valid?
  end
end
