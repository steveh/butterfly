require "spec_helper"

describe Butterfly::Provider::Tumblr do

  let(:valid_response) { File.read(File.join(RSPEC_ROOT, "support/responses/tumblr.xml")) }

  it "should retrieve tumblr likes" do
    FakeWeb.register_uri(:get, "http://www.tumblr.com/api/likes?email=testemail&password=testpassword", :body  =>  valid_response)

    tumblr = Butterfly::Provider::Tumblr.new("testemail", "testpassword")

    tumblr.likes.first.as_json.should == {
      "service" => "tumblr",
      "id" => "3798415726",
      "title" => nil,
      "description" => "<p>zardorz and zardog (<a href=\"http://www.flickr.com/photos/crazyforswayze/4061883550/\">via</a>)</p>",
      "created_at" => Time.new(2011, 3, 12, 16, 31, 14, "+13:00"),
      "liked_at" => nil,
      "tags" => ["dog", "movie"],
      "photo_url" => "http://27.media.tumblr.com/tumblr_lhx09ipxBj1qzmowao1_75sq.jpg",
      "url" => "http://fuckyeahdementia.com/post/3798415726/zardorz-and-zardog-via",
      "type" => "photo",
      "user" => {
        "id" => "fuckyeahdementia",
        "username" => "fuckyeahdementia",
        "name" => "fuckyeahdementia",
        "service_url" => "fuckyeahdementia.tumblr.com",
        "photo_url" => nil,
        "website_url" => nil,
        "location" => nil
      }
    }
  end

end