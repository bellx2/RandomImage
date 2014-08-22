require 'sinatra'
require 'open-uri'
require 'flickraw'

FlickRaw.api_key="42822fcc56da3103c95127a0e02032ab"
FlickRaw.shared_secret="5db2e364816149dd"

get '/' do
  list = flickr.photos.getRecent
  idx = rand(list.count)
  id     = list[idx].id
  secret = list[idx].secret
  info = flickr.photos.getInfo :photo_id => id, :secret => secret
  url = FlickRaw.url_b(info)
  send_file(open(url),type: 'image/jpeg',disposition: 'inline')
end

get '/image' do 
  url = "https://c2.staticflickr.com/6/5567/14986846361_119b517a64_h.jpg"
  send_file(open(url),type: 'image/jpeg',disposition: 'inline')
end
