module Butterfly
  class Like

    attr_accessor :service,
                  :id,
                  :title,
                  :description,
                  :created_at,
                  :liked_at,
                  :tags,
                  :photo_url,
                  :url,
                  :type,
                  :user

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        self.send("#{key}=", value)
      end
    end

    def as_json(options = {})
      instance_values.merge("user" => user.as_json)
    end

  end
end