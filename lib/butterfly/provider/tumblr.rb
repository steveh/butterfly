module Butterfly
  module Provider
    class Tumblr < Base

      base_uri "http://www.tumblr.com/api"

      attr_reader :email, :password

      def initialize(email, password)
        @email, @password = email, password
      end

      def raw
        @raw ||= self.class.get("/likes", :format => :xml, :query => { :email => email, :password => password })
      end

      # TODO - could do some better handling of some forms
      def likes
        @likes ||= raw["tumblr"]["posts"]["post"].collect do |raw_like|
          if raw_like["type"] == "regular"
            title = raw_like["regular_title"]
            body = raw_like["regular_body"]
            type = "text"
            photo_url = nil
          elsif raw_like["type"] == "quote"
            title = raw_like["quote_text"]
            body = raw_like["quote_source"]
            type = "text"
            photo_url = nil
          elsif raw_like["type"] == "photo"
            title = raw_like["photo_caption"]
            body = raw_like["photo_caption"]
            type = "photo"
            photo_url = raw_like["photo_url"].last
          elsif raw_like["type"] == "link"
            title = raw_like["link_text"]
            body = raw_like["link_description"]
            type = "text"
            photo_url = nil
          elsif raw_like["type"] == "conversation"
            title = raw_like["conversation_title"]
            body = raw_like["conversation_text"]
            type = "text"
            photo_url = nil
          elsif raw_like["type"] == "video"
            title = raw_like["video_caption"]
            body = raw_like["video_player"]
            type = "video"
            photo_url = nil
          elsif raw_like["type"] == "audio"
            title = raw_like["audio_caption"]
            body = raw_like["audio_player"]
            type = "audio"
            photo_url = nil
          end

          Butterfly::Like.new({
            :service => "tumblr",
            :id => raw_like["id"],
            :title => title,
            :description => body,
            :created_at => Time.at(raw_like["unix_timestamp"].to_i),
            :liked_at => nil,
            :tags => raw_like["tag"],
            :photo_url => photo_url,
            :url => raw_like["url_with_slug"],
            :type => type,
            :user => Butterfly::User.new({
              :id => raw_like["tumblelog"],
              :username => raw_like["tumblelog"],
              :name => raw_like["tumblelog"],
              :service_url => "#{raw_like["tumblelog"]}.tumblr.com",
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