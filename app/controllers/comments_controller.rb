class CommentsController < ApplicationController
  before_action :require_user

  def create
    @game = Game.find(params[:game_id])
    @comment = current_user.comments.new(comment_params)
    @comment.game = @game

    if @comment.save
      flash[:success] = "Your Comment Has Been Saved"
      redirect_to user_game_path @comment.game.user, @comment.game
    else
      flash[:error] = "are you sure you have your body filled out"
      redirect_to user_game_path @comment.game.user, @comment.game
    end
  end

  def update
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      flash[:success] = "Comment Sucsessfuly updated"
      redirect_to user_game_path @user, @game
    else
      flash[:error] = "Are all the fields filled out? Something went wrong!"
      redirect_to user_game_path @user, @game
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @user = User.find(params[:user_id])
    @comment = current_user.comments.find(params[:id])

    @comment.destroy
    flash[:success] = "Comment was destroyed"
    redirect_to user_game_path @user, @game
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
