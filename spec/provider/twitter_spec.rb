require "spec_helper"

describe Butterfly::Provider::Twitter do

  let(:valid_response) { File.read(File.join(RSPEC_ROOT, "support/responses/twitter.json")) }

  it "should retrieve twitter likes" do
    FakeWeb.register_uri(:get, "http://api.twitter.com/1/favorites/testusername.json?include_entities=1", :body  =>  valid_response)

    twitter = Butterfly::Provider::Twitter.new("testusername")

    twitter.likes.first.as_json.should == {
      "service" => "twitter",
      "id" => 45864664919318529,
      "title" => "Post-it wars in Clerkenwell: @UMLondon started with http://twitpic.com/485g82 so @wearesocial have replied http://twitpic.com/485fs1",
      "description" => "Post-it wars in Clerkenwell: @UMLondon started with http://twitpic.com/485g82 so @wearesocial have replied http://twitpic.com/485fs1",
      "created_at" => Time.new(2011, 3, 11, 4, 12, 42, "+13:00"),
      "liked_at" => nil,
      "tags" => [],
      "photo_url" => nil,
      "url" => "http://twitter.com/qwghlm/status/45864664919318529",
      "type" => "text",
      "user" => {
        "id" => 80363,
        "username" => "qwghlm",
        "name" => "Chris Applegate",
        "service_url" => "http://twitter.com/qwghlm",
        "photo_url" => "http://a2.twimg.com/profile_images/1234065174/Photo_on_2011-02-03_at_22.18_normal.jpg",
        "website_url" => "http://qwghlm.co.uk/",
        "location" => "London, UK"
      }
    }
  end

end