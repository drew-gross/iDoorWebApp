require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/message'
require 'rest_client'
require 'base64'

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
	Base64.decode64(Message.find(params[:id]).content)
end

post '/messages' do
	if request.body.respond_to?(:string) 
		string = request.body.string
	elsif reques.bosy.respond_to?(:read)
		string = request.body.read
	end
	@message = Message.new(:content => Base64.encode64(strign))
	@message.save
	RestClient.post API_URL+"/messages", 
	    :from => "idoor@idoor.heroku.com",
	    :to => "drew.a.gross@gmail.com",
	    :subject => "New Message from iDoor!",
	    :html => '<img src="http://idoor.herokuapp.com/messages/' + @message.id.to_s + '">'
end