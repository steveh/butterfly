module Butterfly
  module Provider
    class Flickr < Base

      EXTRAS = %w(description license date_upload date_taken owner_name icon_server original_format last_update geo tags machine_tags o_dims views media path_alias url_sq url_t url_s url_m url_z url_l url_o)

      base_uri "http://api.flickr.com/services/rest"

      required_parameter :user_id, :api_key

      def raw
        @raw ||= self.class.get("/", :format => :json, :query => { :method => "flickr.favorites.getPublicList", :api_key => api_key, :user_id => user_id, :format => "json", :nojsoncallback => "1", :extras => EXTRAS.join(",") })
      end

      def likes
        @likes ||= raw["photos"]["photo"].collect do |raw_like|
          Butterfly::Like.new({
            :service => "flickr",
            :id => raw_like["id"],
            :title => raw_like["title"],
            :description => raw_like["description"]["_content"],
            :created_at => Time.at(raw_like["dateupload"].to_i),
            :liked_at => Time.at(raw_like["date_faved"].to_i),
            :tags => raw_like["tags"].split(" "),
            :photo_url => raw_like["url_sq"],
            :url => "http://www.flickr.com/photos/#{raw_like["pathalias"]}/#{raw_like["id"]}/",
            :type => "photo",
            :user => Butterfly::User.new({
              :id => raw_like["owner"],
              :username => raw_like["ownername"],
              :name => raw_like["ownername"],
              :service_url => "http://www.flickr.com/photos/#{raw_like["pathalias"]}/",
              :photo_url => nil,
              :website_url => nil,
              :location => nil,
            })
          })
        end
      end

    end
  end
end