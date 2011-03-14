require "spec_helper"

describe Butterfly::Provider::Flickr do

  let(:valid_response) { File.read(File.join(RSPEC_ROOT, "support/responses/flickr.json")) }

  it "should retrieve flickr likes" do
    FakeWeb.register_uri(:get, "http://api.flickr.com/services/rest/?method=flickr.favorites.getPublicList&api_key=testapikey&user_id=testuserid&format=json&nojsoncallback=1&extras=description%2Clicense%2Cdate_upload%2Cdate_taken%2Cowner_name%2Cicon_server%2Coriginal_format%2Clast_update%2Cgeo%2Ctags%2Cmachine_tags%2Co_dims%2Cviews%2Cmedia%2Cpath_alias%2Curl_sq%2Curl_t%2Curl_s%2Curl_m%2Curl_z%2Curl_l%2Curl_o", :body => valid_response)

    flickr = Butterfly::Provider::Flickr.new(:user_id => "testuserid", :api_key => "testapikey")

    flickr.likes.first.as_json.should == {
      "service" => "flickr",
      "id" => "5508838592",
      "title" => "i am thinking it's a sign that the freckles in our eyes are mirror images",
      "description" => "",
      "created_at" => Time.new(2011, 3, 8, 21, 13, 44, "+13:00"),
      "liked_at" => Time.new(2011, 3, 9, 13, 22, 55, "+13:00"),
      "tags" => ["graffiti", "auckland", "inatree2010"],
      "photo_url" => "http://farm6.static.flickr.com/5055/5508838592_9fc5e8a643_s.jpg",
      "url" => "http://www.flickr.com/photos/explode/5508838592/",
      "type" => "photo",
      "user" => {
        "id" => "37996619930@N01",
        "username" => "mandamonium",
        "name" => "mandamonium",
        "service_url" => "http://www.flickr.com/photos/explode/",
        "photo_url" => nil,
        "website_url" => nil,
        "location" => nil
      }
    }
  end

end