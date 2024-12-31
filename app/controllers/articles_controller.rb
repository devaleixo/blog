class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    skip_before_action :authenticate_user!, only: [:show]
  
    def show
        authorize @article
        @comments = Comment.where(article_id: params[:id]).order(created_at: :asc)
        @comment = Comment.new
    end
  
    def new
      @article = Article.new
      @tag = Tag.new
      authorize @article
    end
  
    def edit
    end
  
    def create
      @article = Article.new(article_params)
      @article.author = current_user
      authorize @article
      if @article.save
        redirect_to @article, notice: 'O artigo foi criado com sucesso.'
      else
        render :new
      end
    end
  
    def update
     authorize @article
      if @article.update(article_params)
        redirect_to @article, notice: 'O artigo foi atualizado com sucesso.'
      else
        render :edit
      end
    end
  
    # DELETE /articles/1
    def destroy
      authorize @article
      @article.destroy
      redirect_to root_path, notice: 'O artigo foi excluído com sucesso.'
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Article.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def article_params
        params.require(:article).permit(:title, :rich_body, :photo)
      end
  end
  