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

      def likes
        @likes ||= raw["tumblr"]["posts"]["post"].collect do |raw_like|
          Butterfly::Like.new({
            :service => "tumblr",
            :id => raw_like["id"],
            :title => nil,
            :description => raw_like["photo_caption"], # TODO
            :created_at => Time.at(raw_like["unix_timestamp"].to_i),
            :liked_at => nil,
            :tags => raw_like["tag"],
            :photo_url => raw_like["photo_url"].last,
            :url => raw_like["url_with_slug"],
            :type => "photo",
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