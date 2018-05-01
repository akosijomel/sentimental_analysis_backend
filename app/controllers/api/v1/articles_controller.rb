module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        render json: Article.all
      end

      def create
        @article = Article.new(article_params)

        if @article.save
          render json: @article
        end
      end

      private

      def article_params
        params.require(:article).permit(:headline, :abstract, :category, :url, :image, :anger, :joy, :fear, :sadness, :surprise, :date)
      end

    end
  end
end
