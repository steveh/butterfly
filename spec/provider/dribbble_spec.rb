require "spec_helper"

describe Butterfly::Provider::Dribbble do

  let(:valid_response) { File.read(File.join(RSPEC_ROOT, "support/responses/dribbble.json")) }

  it "should retrieve dribbble likes" do
    FakeWeb.register_uri(:get, "http://api.dribbble.com/players/testusername/shots/likes", :body => valid_response)

    dribbble = Butterfly::Provider::Dribbble.new("testusername")

    dribbble.likes.first.as_json.should == {
      "service" => "dribbble",
      "id" => 123746,
      "title" => "Cross Stitch",
      "description" => "Cross Stitch",
      "created_at" => Time.new(2011, 3, 4, 11, 21, 46, "-05:00"),
      "liked_at" => nil,
      "tags" => [],
      "photo_url" => "http://dribbble.com/system/users/1396/screenshots/123746/shot_1299255706.jpg?1299580058",
      "url" => "http://dribbble.com/shots/123746-Cross-Stitch",
      "type" => "photo",
      "user" => {
        "id" => 1396,
        "username" => "chloe_eardley",
        "name" => "Chloe Angharad Eardley",
        "service_url" => "http://dribbble.com/chloe_eardley",
        "photo_url" => "http://dribbble.com/system/users/1396/avatars/original/me.jpg?1299772963",
        "website_url" => nil,
        "location" => "Bristol, UK",
      }
    }
  end

end