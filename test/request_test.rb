require 'test_helper'

class RequestTest < MiniTest::Should::TestCase
  context "A Request" do
    setup do
      @svc = BananaPhone::Service.new('localhost', 9941)
    end

    should "be created with a Service and type" do
      assert BananaPhone::Request.new(@svc, :call, nil).is_a?(BananaPhone::Request)
    end
  end

  context "A Request instance" do
    setup do
      svc = BananaPhone::Service.new('localhost', 9941)
      @req = BananaPhone::Request.new(@svc, :call, nil)
    end

    should "return a Mod instance" do
      assert @req.myfun.is_a?(BananaPhone::Mod)
    end
  end
end