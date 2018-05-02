module Api
  module V1
    class AmericansController < ApplicationController
      def index
        render json: American.all
      end

      def create
        @american = American.new(american_params)

        if @american.save
          render json: @american
        end
      end

      private

      def american_params
        params.require(:american).permit(:headline, :abstract, :category, :url, :image, :anger, :joy, :fear, :sadness, :surprise, :date)
      end
    end
  end
end
