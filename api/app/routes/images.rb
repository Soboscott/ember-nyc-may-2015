require 'json'

require './app/models/image'
require './app/models/s3_direct'

get '/api/images' do
  content_type :json
  Image.reverse_order(:uploadedAt).to_json(root: true)
end

post '/api/images' do
  image_params = JSON.parse(request.body.read, symbolize_names: true)[:image]
  image = Image.new({
    url: image_params[:url],
    name: image_params[:name],
    uploadedAt: DateTime.now
  })

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
    key: "uploads/${filename}",
    acl: 'public-read'
  }).as_params.to_json
end
