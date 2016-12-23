require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    @game = Game.new(title: "game", description: "fun", code: "console.log('hello')")
  end

  def test_game
    assert @game.valid?
  end

  def test_title_needed
    @game.title = ""
    assert_not @game.valid?
  end

  def test_description_needed
    @game.description = ""
    assert_not @game.valid?
  end

  def test_valid_without_code
    @game.code = ""
    assert @game.valid?
  end
end
