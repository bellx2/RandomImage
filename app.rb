require 'sinatra'
require 'open-uri'

get '/' do
  @text = 'hi'
  erb :index
end

get '/image' do 
  url = "https://c2.staticflickr.com/6/5567/14986846361_119b517a64_h.jpg"
  send_file(open(url),type: 'image/jpeg',disposition: 'inline')
end


