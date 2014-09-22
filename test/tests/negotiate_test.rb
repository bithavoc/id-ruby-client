require_relative '../test_helper'

class NegotiateTest < MiniTest::Test

    def setup
        @client = create_client
    end

    def create_client
        Bithavoc::Identity::Client.new('59abb3124156a6e47e39108e36f9f380')
    end

    def test_create
        stub_request(:post, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/tokens").with(:body => "code=some_auth_code").to_return(:status=> 201, :body=> '{"token": "some_auth_token", "user": {"email": "johan@johan.com", "fullname": "Johan Johanson"}}', :headers=>{"Content-Type"=>"application/json"})
        info = @client.negotiate('some_auth_code')
        assert_equal "some_auth_token", info['token']
        assert_equal "johan@johan.com", info['user']['email']
    end

    def test_invalid_access_code
        stub_request(:post, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/tokens").with(:body => "code=invalid_code").to_return(:status=> 422, :body=> '{"message": "Invalid authorization code"}', :headers=>{"Content-Type"=>"application/json"})
        err = assert_raises(Bithavoc::Identity::IdentityError) do
            @client.negotiate('invalid_code')
        end
        assert_equal "Invalid authorization code", err.message
    end
end

