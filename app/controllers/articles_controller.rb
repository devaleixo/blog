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
      @tagging = Tagging.new
      @tag = Tag.new
      @tags = Tag.all.order(:title)
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
      if params[:article][:tag_ids]
        params[:article][:tag_ids].each do |tag_id|
          Tagging.create(article: @article, tag: Tag.find(tag_id))
        end
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

    def import
      begin
        if params[:article_import][:file].present?
          # Verifica se o arquivo é um arquivo .txt
          if File.extname(params[:article_import][:file].original_filename) == ".txt"
            ArticleImportsJob.perform_now(params[:article_import][:file].path, current_user)
            redirect_to articles_path, notice: "A importação está sendo processada."
          else
            redirect_to articles_path, alert: "Apenas arquivos .txt são permitidos."
          end
        else
          redirect_to articles_path, alert: "Por favor, envie um arquivo."
        end
      rescue => e
        redirect_to articles_path, alert: "Erro ao importar artigos: #{e.message}"
      end
    end

    def imports
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
