class Image < Sequel::Model; end

Image.plugin :json_serializer
