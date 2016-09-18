require 'sinatra'
require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    erb :home
  end
end
