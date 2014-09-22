require_relative '../test_helper'

class ConfirmTest < MiniTest::Test

    def setup
        @client = create_client
    end

    def create_client
        Bithavoc::Identity::Client.new('59abb3124156a6e47e39108e36f9f380')
    end

    def test_confirm_success
        stub_request(:post, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/confirm").with(:body => "code=email_code").to_return(:status=> 200, :body=> '{"auth_code": "some_auth_code"}', :headers=>{"Content-Type"=>"application/json"})
        code = @client.confirm('email_code')
        assert_equal "some_auth_code", code
    end

    def test_invalid_access_code
        stub_request(:post, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/confirm").with(:body => "code=invalid_code").to_return(:status=> 422, :body=> '{"message": "Invalid confirmation code"}', :headers=>{"Content-Type"=>"application/json"})
        err = assert_raises(Bithavoc::Identity::IdentityError) do
            @client.confirm('invalid_code')
        end
        assert_equal "Invalid confirmation code", err.message
    end
end

