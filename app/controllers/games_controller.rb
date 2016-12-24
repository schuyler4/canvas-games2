class GamesController < ApplicationController
  before_action :require_user, only: [:new, :edit, :create, :update, :destroy]

  def index
    @games = Game.all
  end

  def new
    @user = current_user
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
    @game.user = current_user

    if @game.save
      redirect_to user_game_path(@user, @game)
    else
      render 'new'
    end
  end

  def update
    @game = Game.find(params[:id])
    @game.user = current_user

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
