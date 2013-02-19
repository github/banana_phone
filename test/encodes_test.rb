require 'test_helper'

class EncodesTest < MiniTest::Should::TestCase
  context "An Encodes includer" do
    setup do
      @enc = Enc.new
    end

    context "ruby request encoder" do
      should "return BananaPhone encoded request" do
        bert = "\x94\xD4\x00\x04call\xD4\x00\x05mymod\xD4\x00\x05myfun\x93\x01\x02\x03"
        assert_equal bert, @enc.encode_ruby_request([:call, :mymod, :myfun, [1, 2, 3]])
      end
    end

    context "bert response decoder" do
      should "return response when reply" do
        req = @enc.encode_ruby_request([:reply, [1, 2, 3]])
        res = @enc.decode_bert_response(req)
        assert_equal [1, 2, 3], res
      end

      should "return nil when noreply" do
        req = @enc.encode_ruby_request([:noreply])
        res = @enc.decode_bert_response(req)
        assert_equal nil, res
      end

      should "raise a ProtocolError error when protocol level error is returned" do
        req = @enc.encode_ruby_request([:error, [:protocol, 1, "class", "invalid", []]])
        assert_raises(BananaPhone::ProtocolError) do
          @enc.decode_bert_response(req)
        end
      end

      should "raise a ServerError error when server level error is returned" do
        req = @enc.encode_ruby_request([:error, [:server, 1, "class", "invalid", []]])
        assert_raises(BananaPhone::ServerError) do
          @enc.decode_bert_response(req)
        end
      end

      should "raise a UserError error when user level error is returned" do
        req = @enc.encode_ruby_request([:error, [:user, 1, "class", "invalid", []]])
        assert_raises(BananaPhone::UserError) do
          @enc.decode_bert_response(req)
        end
      end

      should "raise a ProxyError error when proxy level error is returned" do
        req = @enc.encode_ruby_request([:error, [:proxy, 1, "class", "invalid", []]])
        assert_raises(BananaPhone::ProxyError) do
          @enc.decode_bert_response(req)
        end
      end
    end
  end
end