require 'sinatra'
require 'dotenv'
require 'sequel'
require 'json'
Dotenv.load

require './db'
require './app/routes/images'

# Monkeypatch Time#to_json for iOS
class Time
  def to_json(*opts)
    (to_i * 1000).to_s
  end
end
