class GamesController < ApplicationController
  before_action :require_user, only: [:new, :edit, :create, :update, :destroy]

  def index
    @games = Game.all
  end

  def new
    @game = current_user.games.new
  end

  def show
    @game = Game.find(params[:id])
    @comment = current_user.comments.new
  end

  def edit
    @game = Game.find(params[:user_id], params[:id])
  end

  def create
    @game = current_user.games.new(game_params)
    @game.user = current_user

    if @game.save
      flash[:success] = "your game has been saved successfuly"
      redirect_to user_game_path(@game.user, @game)
    else
      flash[:error] = "something is not right are your sure your
        title and description are filled out"
      render 'new'
    end
  end

  def update
    @game = current_user.games.find(params[:id])

    if @game.update(game_params)
      redirect_to user_game_path(current_user, @game)
      flash[:success] = "your game has been saved successfuly"
    else
      flash[:error] = "something is not right are your sure your
        title and description are filled out"

      render 'new'
    end
  end

  def destroy
    @game = current_user.games.find(params[:id])
    @game.delete

    redirect_to user_path(current_user)
  end

  private

  def game_params
    params.require(:game).permit(:title, :description, :code)
  end
end
