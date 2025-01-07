class PagesController < ApplicationController
  def home
    @articles = Article.order(created_at: :desc).page(params[:page]).per(3)
  end
end
