# encoding: utf-8
require 'spec_helper'

describe "A RViki::Routable instance" do
  class DummyRandomClient
    include RViki::Routable

    base_uri "http://someapi.com/base"
    route_get "/no_param_prefix", as: :test1
    route_get "/param_prefix/:something", as: :test2
  end

  describe "request" do
    it "defines its own method to request to server" do
      DummyRandomClient.should_receive(:get).with("/no_param_prefix", {query: {}})
      dc = DummyRandomClient.new
      dc.test1
    end

    context "when request parameter exists" do
      it "should pass it" do
        DummyRandomClient.should_receive(:get).with("/no_param_prefix", {query: {hello: "world"}})
        dc = DummyRandomClient.new
        dc.test1(hello: "world")
      end
    end

    context "when request parameter is in the route pattern" do
      it "should replace the route pattern with the correct value" do
        DummyRandomClient.should_receive(:get).with("/param_prefix/yes", {query: {}})
        dc = DummyRandomClient.new
        dc.test2(something: "yes")
      end
    end
  end

  it "adds to route listing" do
    DummyRandomClient.routes.should == {
      :test1 => ["/no_param_prefix", []],
      :test2 => ["/param_prefix/:something", [:something]]
    }
  end
end

