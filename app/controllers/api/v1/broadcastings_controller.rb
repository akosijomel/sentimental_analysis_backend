module Api
  module V1
    class BroadcastingsController < ApplicationController
      def index
        render json: Broadcasting.all
      end

      def create
        @broadcasting = Broadcasting.new(broadcasting_params)

        if @broadcasting.save
          render json: @broadcasting
        end
      end

      private

      def broadcasting_params
        params.require(:broadcasting).permit(:headline, :abstract, :url, :image, :anger, :joy, :fear, :sadness, :surprise, :date)
      end

    end
  end
end
