# encoding: utf-8
require 'spec_helper'

describe RViki::ClientV1 do
  subject { described_class.routes }
  it { subject[:shows].should == ["/shows.json", []] }
  it { subject[:shows_item].should == ["/shows/:id.json", [:id]] }
end

describe RViki::ClientV2 do
  subject { described_class.routes }
  it { subject[:shows].should == ["/shows.json", []] }
  it { subject[:shows_item].should == ["/shows/:id.json", [:id]] }
  it { subject[:featured].should == ["/featured.json", []] }
  it { subject[:news].should == ["/news.json", []] }

  it { subject[:channels].should == ["/channels.json", []] }
  it { subject[:channels_item].should == ["/channels/:id.json", [:id]] }
  it { subject[:channel_videos].should == ["/channel/:id/videos.json", [:id]] }

  it { subject[:posts].should == ["/posts.json", []] }

  it { subject[:videos].should == ["/videos.json", []] }
  it { subject[:video_casts].should == ["/videos/:id/casts.json", [:id]] }
  it { subject[:video_parts].should == ["/videos/:id/parts.json", [:id]] }
  it { subject[:video_posts].should == ["/videos/:id/recommended.json", [:id]] }
end

describe RViki::ClientV3 do
  subject { described_class.routes }
  it { subject[:custom].should == ["/custom.json", []] }
end

