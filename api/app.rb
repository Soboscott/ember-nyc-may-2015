require 'sinatra'
require 'dotenv'
require 'sequel'
Dotenv.load

require './db'
require './app/routes/images'
