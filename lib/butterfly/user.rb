module Butterfly
  class User

    attr_accessor :id,
                :username,
                :name,
                :service_url,
                :photo_url,
                :website_url,
                :location

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        self.send("#{key}=", value)
      end
    end

  end
end