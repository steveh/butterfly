module Butterfly
  module Provider
    class Twitter < Base

      base_uri "http://api.twitter.com/1"

      required_parameter :username

      def raw
        @raw ||= self.class.get("/favorites/#{username}.json", :format => :json, :query => { :include_entities => 1 })
      end

      def likes
        @likes ||= raw.collect do |raw_like|
          Butterfly::Like.new({
            :service => "twitter",
            :id => raw_like["id"],
            :title => raw_like["text"],
            :description => raw_like["text"],
            :created_at => Time.parse(raw_like["created_at"]),
            :liked_at => nil,
            :tags => [],
            :photo_url => nil,
            :url => "http://twitter.com/#{raw_like["user"]["screen_name"]}/status/#{raw_like["id"]}",
            :type => "text",
            :user => Butterfly::User.new({
              :id => raw_like["user"]["id"],
              :username => raw_like["user"]["screen_name"],
              :name => raw_like["user"]["name"],
              :service_url => "http://twitter.com/#{raw_like["user"]["screen_name"]}",
              :photo_url => raw_like["user"]["profile_image_url"],
              :website_url => raw_like["user"]["url"],
              :location => raw_like["user"]["location"],
            })
          })
        end
      end

    end
  end
end