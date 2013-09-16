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
	Message.find(params[:id]).content
end

post '/messages' do
	@content = Message.new(params[:content])
	RestClient.post API_URL+"/messages", 
	    :from => "idoor@idoor.heroku.com",
	    :to => "drew.a.gross@gmail.com",
	    :subject => "New Message from iDoor!",
	    :html => @content
	@message.save
	@content
end

message = <<MESSAGE_END
From: The Door <door@idoor.heroku.com>
To: Drew Gross <drew.a.gross+idoor@gmail.com>
Subject: New Message from iDoor!

Test message
MESSAGE_END