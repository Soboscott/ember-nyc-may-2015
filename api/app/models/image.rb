class Image < Sequel::Model
  restrict_primary_key
  plugin :json_serializer
end
