class Asset
  include ActiveModel::Model

  attr_accessor :file
  attr_reader   :url

  BucketName = 'chiha-blog-thumb'
  BasePath   = 'assets/'

  def save
    filename = Time.zone.now.strftime('%Y%m%d%H%M%S%6N') + File.extname(@file.original_filename)
    obj = s3.bucket(BucketName).object(BasePath + filename)
    obj.upload_file(@file.tempfile)
    @url = obj.public_url(virtual_host: true).gsub(/^http:\/\/#{BucketName}/, "https://#{ENV['AWS_S3_PASS']}")
  end

  private
  def s3
    @s3 ||= Aws::S3::Resource.new
  end
end