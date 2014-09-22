require_relative '../test_helper'

class SignUpTest < MiniTest::Test

    def setup
        @client = create_client
    end

    def create_client
        Bithavoc::Identity::Client.new('59abb3124156a6e47e39108e36f9f380')
    end

    def test_success_signup
        stub_request(:post, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/sign-up").with(:body => "email=johan%40johan.com&fullname=chill%20bithavoc&password=pass1&password_confirmation=pass1").to_return(:status=> 200, :body=> '{}', :headers=>{"Content-Type"=>"application/json"})
        @client.sign_up(email: 'johan@johan.com', password: 'pass1', fullname: 'chill bithavoc')
    end

    def test_error_signup
        stub_request(:post, "https://id.bithavoc.io/apps/59abb3124156a6e47e39108e36f9f380/sign-up").with(:body => "email=johan%40johan.com&fullname=chill%20bithavoc&password=pass1&password_confirmation=pass1").to_return(:status=> 422, :body=> '{"message": "Email already taken"}', :headers=>{"Content-Type"=>"application/json"})
        err = assert_raises(Bithavoc::Identity::IdentityError) do
            @client.sign_up(email: 'johan@johan.com', password: 'pass1', fullname: 'chill bithavoc')
        end
        assert_equal "Email already taken", err.message
    end

end

