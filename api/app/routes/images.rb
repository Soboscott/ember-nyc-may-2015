require 'securerandom'

require './app/models/image'
require './app/models/s3_direct'

get '/api/images' do
  content_type :json
  Image.reverse_order(:uploaded_at).to_json(root: true)
end

post '/api/images' do
  request.body.rewind
  data = JSON.parse(request.body.read)
  image = Image.new.from_json_node(data['image'])
  image.uploaded_at = DateTime.now

  content_type :json
  halt 402, 'Not valid' unless image.save
  image.to_json(root: true)
end

get '/api/images/s3_direct' do
  content_type :json

  expires_in = DateTime.now + (10/1440.0) # 10 minutes
  S3Direct.new({
    bucket: 'ember-nyc-test',
    expiration: expires_in,
    key: "uploads/#{SecureRandom.uuid}",
    acl: 'public-read'
  }).to_json
end
