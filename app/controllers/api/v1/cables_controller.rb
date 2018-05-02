module Api
  module V1
    class CablesController < ApplicationController
      def index
        render json: Cable.all
      end

      def create
        @cable = Cable.new(cable_params)

        if @cable.save
          render json: @cable
        end
      end

      private

      def cable_params
        params.require(:cable).permit(:headline, :abstract, :url, :image, :anger, :joy, :fear, :sadness, :surprise, :date)
      end
    end

  end
end
