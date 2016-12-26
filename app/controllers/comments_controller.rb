class CommentsController < ApplicationController
  before_action :require_user

  def create
    @game = Game.find(params[:game_id])
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.game = @game
    if @comment.save
      flash[:success] = "Your Comment Has Been Saved"
      redirect_to user_game_path(@game.user, @game)
    else
      flash[:error] = "You screwed up your comment"
      redirect_to user_game_path(@game.user, @game)
    end
  end

  def update
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
    @comment = Comment.find(params[:id])
    redirect_path = user_game_path(@user, @game)

    if current_user == @user
      if @comment.update(comment_params)
        flash[:success] = "Comment Sucsessfuly updated"
        redirect_to(redirect_path)
      else
        flash[:error] = "Are all the fields filled out? something went wrong"
        redirect_to(redirect_path)
      end
    else
      flash[:error] = "you do not have permision to update that"
      redirect_to(redirect_path)
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    redirect_path = user_game_path(@user, @game)

    if current_user == @user || current_user == @comment.user
      @game = Game.find(params[:game_id])
      @user = User.find(params[:user_id])

      @comment.destroy
      flash[:success] = "Comment was destroyed"
      redirect_to(redirect_path)
    else
      flash[:error] = "You Do Not Have permision to delete that"
      redirect_to(redirect_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
