require_relative '../test_helper'

class ValidateTest < MiniTest::Test

    def setup
        @client = create_client
    end

    def create_client
        Bithavoc::Identity::Client.new('59abb3124156a6e47e39108e36f9f380')
    end

    def test_validate_success
        stub_request(:get, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/tokens/valid_token").to_return(:status=> 200, :body=> '{"token": "valid_token", "user": {"email": "johan@example.com"}}', :headers=>{"Content-Type"=>"application/json"})
        user = @client.validate('valid_token')
        assert_equal({"email" => "johan@example.com"}, user)
    end

    def test_validate_failed
        stub_request(:get, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/tokens/invalid_token").to_return(:status=> 403, :body=> '{"message": "Invalid confirmation code"}', :headers=>{"Content-Type"=>"application/json"})
        err = assert_raises(Bithavoc::Identity::IdentityError) do
            @client.validate('invalid_token')
        end
        assert_equal "Invalid confirmation code", err.message
    end
end

