class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    @comment.article = @article
    if user_signed_in?
    @comment.author = current_user
    else
      @comment.anonymous = true
    end
    @comment.save
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end
end
