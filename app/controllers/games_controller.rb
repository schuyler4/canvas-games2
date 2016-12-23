class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.delete

    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:title, :description, :code)
  end
end
