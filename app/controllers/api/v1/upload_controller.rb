module Api
  module V1
    class UploadController < ApplicationController
      def upload
        if params[:file].nil?
          render json: { message: '이미지가 오지 않았어옹' }, status: :bad_request
          return
        end

        file_name = "#{SecureRandom.uuid}_#{params[:file].original_filename}"

        obj = S3_BUCKET.object(file_name)
        obj.put(body: params[:file].read)

        url = obj.public_url

        render json: { url: url }, status: :ok

      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end
