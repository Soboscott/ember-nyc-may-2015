require 'json'

require './app/models/image'
require './app/models/s3_direct'

get '/api/images' do
  content_type :json
  Image.all.to_json
end

get '/api/images/s3_direct' do
  content_type :json

  expires_in = DateTime.now + (10/1440.0) # 10 minutes
  S3Direct.new({
    bucket: 'ember-nyc-test',
    expiration: expires_in,
    key: "uploads/${filename}",
    acl: 'public-read'
  }).as_params.to_json
end
