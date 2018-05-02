module Api
  module V1
    class FoxesController < ApplicationController
      def index
        render json: Fox.all
      end

      def create
        @fox = Fox.new(fox_params)

        if @fox.save
          render json: @fox
        end
      end

      private

      def fox_params
        params.require(:fox).permit(:headline, :abstract, :url, :image, :anger, :joy, :fear, :sadness, :surprise, :date)
      end

    end
  end
end
