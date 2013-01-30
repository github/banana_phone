require 'test_helper'

class EncodesTest < MiniTest::Should::TestCase
  context "An Encodes includer" do
    setup do
      @enc = Enc.new
    end

    context "ruby request encoder" do
      should "return BERT-RPC encoded request" do
        bert = "\x94\xD8\x00\x04\x01call\xD8\x00\x05\x01mymod\xD8\x00\x05\x01myfun\x93\x01\x02\x03"
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
        assert_raises(BERTRPC::ProtocolError) do
          @enc.decode_bert_response(req)
        end
      end

      should "raise a ServerError error when server level error is returned" do
        req = @enc.encode_ruby_request([:error, [:server, 1, "class", "invalid", []]])
        assert_raises(BERTRPC::ServerError) do
          @enc.decode_bert_response(req)
        end
      end

      should "raise a UserError error when user level error is returned" do
        req = @enc.encode_ruby_request([:error, [:user, 1, "class", "invalid", []]])
        assert_raises(BERTRPC::UserError) do
          @enc.decode_bert_response(req)
        end
      end

      should "raise a ProxyError error when proxy level error is returned" do
        req = @enc.encode_ruby_request([:error, [:proxy, 1, "class", "invalid", []]])
        assert_raises(BERTRPC::ProxyError) do
          @enc.decode_bert_response(req)
        end
      end
    end
  end
end