class AssetsController < ApplicationController
  def create
    asset = Asset.new(asset_params)

    unless [
      'image/png',
      'image/gif',
      'image/jpeg',
      'image/tiff',
    ].include?(asset.file.content_type)
      render json: { error: "file type (#{asset.file.content_type}) is not allowed" }, status: 500 and return
    end

    asset.upload
    render json: { filename: asset.url }
  end

  private

  def asset_params
    params.require(:asset).permit(:file)
  end
end