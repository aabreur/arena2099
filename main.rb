require 'sinatra'
# require 'sinatra/reloader' if development?
require './models.rb'


get "/" do
	@fighters = Fighter.all.to_a
	erb :fighters
end

post "/gen" do
end