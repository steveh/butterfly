require "spec_helper"

describe Butterfly::Provider::Tumblr do

  let(:valid_response) { File.read(File.join(RSPEC_ROOT, "support/responses/tumblr.xml")) }

  it "should retrieve tumblr likes" do
    FakeWeb.register_uri(:get, "http://www.tumblr.com/api/likes?email=testemail&password=testpassword", :body => valid_response)

    tumblr = Butterfly::Provider::Tumblr.new("testemail", "testpassword")

    tumblr.likes.first.as_json.should == {
      "service" => "tumblr",
      "id" => "3851619268",
      "title" => "Text title",
      "description" => "<p>Test post with some <strong>HTMLs</strong></p>",
      "created_at" => Time.new(2011, 3, 14, 21, 1, 39, "+13:00"),
      "liked_at" => nil,
      "tags" => nil,
      "photo_url" => nil,
      "url" => "http://butterflyapitest.tumblr.com/post/3851619268/text-title",
      "type" => "text",
      "user" =>  {
        "id" => "butterflyapitest",
        "username" => "butterflyapitest",
        "name" => "butterflyapitest",
        "service_url" => "butterflyapitest.tumblr.com",
        "photo_url" => nil,
        "website_url" => nil,
        "location" => nil
      }
    }

    tumblr.likes[0].type.should == "text"
    tumblr.likes[0].title.should == "Text title"
    tumblr.likes[0].description.should == "<p>Test post with some <strong>HTMLs</strong></p>"
    tumblr.likes[0].photo_url.should be_nil

    tumblr.likes[1].type.should == "text"
    tumblr.likes[1].title.should == "I am a quote"
    tumblr.likes[1].description.should == "John <strong>Smith</strong>"
    tumblr.likes[1].photo_url.should be_nil

    tumblr.likes[2].type.should == "photo"
    tumblr.likes[2].title.should == "<p>Caption with <strong>HTML</strong></p>"
    tumblr.likes[2].description.should == "<p>Caption with <strong>HTML</strong></p>"
    tumblr.likes[2].photo_url.should == "http://28.media.tumblr.com/tumblr_li1fnzjnOO1qi2hiqo1_75sq.jpg"

    tumblr.likes[3].type.should == "text"
    tumblr.likes[3].title.should == "Linky link link"
    tumblr.likes[3].description.should == "<p>Cabbages and <strong>HTML</strong></p>"
    tumblr.likes[3].photo_url.should be_nil

    tumblr.likes[4].type.should == "text"
    tumblr.likes[4].title.should == "I like camels"
    tumblr.likes[4].description.should == "Tourist: Could you give us directions to Olive Garden?\r\nNew Yorker: No, but I could give you directions to an actual Italian restaurant."
    tumblr.likes[4].photo_url.should be_nil

    tumblr.likes[5].type.should == "video"
    tumblr.likes[5].title.should == "<p>Caption with <strong>HTML</strong></p>"
    tumblr.likes[5].description.should == "<object width=\"400\" height=\"325\"><param name=\"movie\" value=\"http://www.youtube.com/v/JZOxqVl5oP4&amp;rel=0&amp;egm=0&amp;showinfo=0&amp;fs=1\"></param><param name=\"wmode\" value=\"transparent\"></param><param name=\"allowFullScreen\" value=\"true\"></param><embed src=\"http://www.youtube.com/v/JZOxqVl5oP4&amp;rel=0&amp;egm=0&amp;showinfo=0&amp;fs=1\" type=\"application/x-shockwave-flash\" width=\"400\" height=\"325\" allowFullScreen=\"true\" wmode=\"transparent\"></embed></object>"
    tumblr.likes[5].photo_url.should be_nil

    tumblr.likes[6].type.should == "audio"
    tumblr.likes[6].title.should == "<p>I am a test <strong>audio </strong>upload</p>"
    tumblr.likes[6].description.should == "<embed type=\"application/x-shockwave-flash\" src=\"http://assets.tumblr.com/swf/audio_player.swf?audio_file=http://www.tumblr.com/audio_file/3851665622/tumblr_li1fvesD151qi2hiq&color=FFFFFF\" height=\"27\" width=\"207\" quality=\"best\"></embed>"
    tumblr.likes[6].photo_url.should be_nil
  end

end