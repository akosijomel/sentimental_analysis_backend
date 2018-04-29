module Api
  module V1
    class SentimentsController < ApplicationController

      def index
        render json: Sentiment.all
      end

      def create
        @sentiment = Sentiment.new(sentiment_params)

        if @sentiment.save
          render json: @sentiment
        end
      end


      private
      def sentiment_params
        params.require(:sentiment).permit(:anger, :joy, :fear, :sadness, :surprise)
      end

    end
  end
end
