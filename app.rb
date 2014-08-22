require 'sinatra'
require 'open-uri'
require 'flickraw'

FlickRaw.api_key="42822fcc56da3103c95127a0e02032ab"
FlickRaw.shared_secret="5db2e364816149dd"

get '/' do
  # list = flickr.photos.getRecent
  list = flickr.interestingness.getList :per_page => 50
  idx = rand(list.count)
  id     = list[idx].id
  secret = list[idx].secret
  info = flickr.photos.getInfo :photo_id => id, :secret => secret
  url = FlickRaw.url_b(info)
  send_file(open(url),type: 'image/jpeg',disposition: 'inline')
end

