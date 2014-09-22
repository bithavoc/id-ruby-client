require_relative '../test_helper'

class SignInTest < MiniTest::Test

    def setup
        @client = create_client
    end

    def create_client
        Bithavoc::Identity::Client.new('59abb3124156a6e47e39108e36f9f380')
    end

    def test_success_signin
        stub_request(:post, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/sign-in").with(:body => "email=johan%40johan.com&password=pass1&password_confirmation=pass1").to_return(:status=> 200, :body=> '{"auth_code": "some_auth_code"}', :headers=>{"Content-Type"=>"application/json"})
        auth_code = @client.sign_in('johan@johan.com', 'pass1')
        assert_equal "some_auth_code", auth_code
    end

    def test_invalid_access_code
        stub_request(:post, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/sign-in").with(:body => "email=wrong%40example.com&password=wrong&password_confirmation=wrong").to_return(:status=> 422, :body=> '{"message": "wrong password"}', :headers=>{"Content-Type"=>"application/json"})
        err = assert_raises(Bithavoc::Identity::IdentityError) do
            @client.sign_in('wrong@example.com', 'wrong')
        end
        assert_equal "wrong password", err.message
    end

end

