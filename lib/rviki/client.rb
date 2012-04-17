# encoding: utf-8
module RViki
  class Client
    include Routable

    base_uri 'http://www.viki.com/api/v2'
    headers "Content-Type" => "application/json", "User-Agent" => "VikiMobile/4.0 RViki::Client"
    format :json

    route_get "/shows.json", as: :shows
    route_get "/shows/:id.json", as: :shows_item
    route_get "/featured.json", as: :featured
    route_get "/news.json", as: :news

    route_get "/channels.json", as: :channels
    route_get "/channels/:id.json", as: :channels_item
    route_get "/channel/:id/videos.json", as: :channel_videos

    route_get "/posts.json", as: :posts

    route_get "/videos.json", as: :videos
    route_get "/videos/:id/casts.json", as: :video_casts
    route_get "/videos/:id/parts.json", as: :video_parts
    route_get "/videos/:id/recommended.json", as: :video_posts
  end
end

