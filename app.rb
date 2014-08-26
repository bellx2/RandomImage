require 'sinatra'
require 'open-uri'
require 'json'

get '/' do
  items = getFlickrItems.sort_by{rand}
  url = getImageInfo(items[0])['url']
  send_file(open(url),type: 'image/jpeg',disposition: 'inline')
end

get '/images' do
  feed = Array.new
  items = getFlickrItems.sort_by{rand}
  10.times do |idx|
    info = getImageInfo(items[idx])
    feed << info
  end
  feed.to_json
end

def getFlickrItems
  # https://www.flickr.com/services/feeds/docs/photos_public/
  tags = ['animal']
  uri = URI.parse("https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=#{tags.join(',')}&nojsoncallback=1")
  p uri
  json = Net::HTTP.get(uri)
  JSON.parse(json)['items']
end

def getImageInfo(item)
  data = Hash.new
  data['url'] = item['media']['m'].gsub(/_m/,'')
  data['title'] = item['title']
  data
end
