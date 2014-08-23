require 'sinatra'
require 'open-uri'
require 'json'

get '/' do
  items = getFlickrItems.sort_by{rand}
  url = getImageURL(items[0])
  send_file(open(url),type: 'image/jpeg',disposition: 'inline')
end

get '/images' do
  feed = Array.new
  items = getFlickrItems.sort_by{rand}
  10.times do |idx|
    url = getImageURL(items[idx])
    feed << {"url" => url}
  end
  feed.to_json
end

def getFlickrItems
  uri = URI.parse('https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1')
  json = Net::HTTP.get(uri)
  JSON.parse(json)['items']
end

def getImageURL(item)
  item['media']['m'].gsub(/_m/,'')
end
