class GamesController < ApplicationController
  before_action :require_user, only: [:new, :edit, :create, :update, :destroy]

  def index
    @user = current_user
    @games = Game.all
  end

  def new
    @user = current_user
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    @user = current_user
    @comment = Comment.new
    @comments = @game.comments.all
  end

  def edit
    @game = Game.find(params[:user_id], params[:id])
    @user = @game.user
  end

  def create
    @game = Game.new(game_params)
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
    @game = Game.find(params[:id])
    @user = @game.user

    if @game.update(game_params)
      redirect_to user_game_path(@user, @game)
      flash[:success] = "your game has been saved successfuly"
    else
      flash[:error] = "something is not right are your sure your
        title and description are filled out"

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
