require 'sinatra'
require 'omniauth-splitwise'
require 'json'
require 'splitwise'

SPLITWISE_KEY = <YOUR_CONSUMER_KEY> 
SPLITWISE_SECRET = <YOUR_CONSUMER_SECRET>

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :splitwise, SPLITWISE_KEY, SPLITWISE_SECRET
end

get '/' do
  redirect '/auth/splitwise'
end

get '/currencies' do
  response = JSON.parse(Splitwise::Request.new.fetch("get_currencies"))
  response.to_json
end

get '/categories' do
  response = JSON.parse(Splitwise::Request.new.fetch("get_categories"))
  response.to_json
end

get '/auth/:provider/callback' do
  content_type 'application/json'
  @access_token = request.env["omniauth.auth"]["extra"]["access_token"]
  Splitwise.access_token = @access_token
  {status: "Authenticated"}.to_json
end

get '/get_current_user' do
	request = JSON.parse(Splitwise::Users.get_current_user)
	request.to_json
end

get '/auth/failure' do
  content_type 'application/json'
  MultiJson.encode(request.env)
end
