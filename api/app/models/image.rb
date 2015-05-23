require 'aws/s3'

class Image
  class << self
    def connect!
      return if @connected
      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      )
      @connected = true
    end

    def all
      connect!
      AWS::S3::Bucket.objects('ember-nyc-test').map do |file|
        about = file.about
        {
          id: about['x-amz-request-id'],
          filename: file.key,
          uploaded_at: about['date'],
          url: file.url(authenticated: false)
        }
      end
    end
  end
end
