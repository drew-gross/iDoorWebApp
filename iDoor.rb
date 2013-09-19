require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/message'
require 'rest_client'

API_KEY = ENV['MAILGUN_API_KEY']
API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/app18128146.mailgun.org"


get '/' do 
	@messages = Message.all
	erb :messages
end

get '/messages' do
	@messages = Message.all
	erb :messages
end

get '/messages/:id' do
	content_type 'image/jpeg'
	Message.find(params[:id]).content
end

post '/messages' do
	@message = Message.new(:content => request.body.string)
	RestClient.post API_URL+"/messages", 
	    :from => "idoor@idoor.heroku.com",
	    :to => "drew.a.gross@gmail.com",
	    :subject => "New Message from iDoor!",
	    :text => "http://idoor.herokuapp.com/messages/" + @message.id.to_s
end