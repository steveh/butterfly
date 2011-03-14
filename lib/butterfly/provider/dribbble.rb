module Butterfly
  module Provider
    class Dribbble < Base

      base_uri "http://api.dribbble.com"

      required_parameter :username

      def raw
        @raw ||= self.class.get("/players/#{username}/shots/likes", :format => :json)
      end

      def likes
        @likes ||= raw["shots"].collect do |raw_like|
          Butterfly::Like.new({
            :service => "dribbble",
            :id => raw_like["id"],
            :title => raw_like["title"],
            :description => raw_like["title"],
            :created_at => DateTime.parse(raw_like["created_at"]),
            :liked_at => nil,
            :tags => [],
            :photo_url => raw_like["image_url"],
            :url => raw_like["url"],
            :type => "photo",
            :user => Butterfly::User.new({
              :id => raw_like["player"]["id"],
              :username => raw_like["player"]["username"],
              :name => raw_like["player"]["name"],
              :service_url => raw_like["player"]["url"],
              :photo_url => raw_like["player"]["avatar_url"],
              :website_url => raw_like["player"]["website_url"],
              :location => raw_like["player"]["location"],
            })
          })
        end
      end

    end
  end
end