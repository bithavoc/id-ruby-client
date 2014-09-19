require "bithavoc/identity/version"
require "bithavoc/identity/error"
require 'httparty'

module Bithavoc
    module Identity
        class Client
            include HTTParty

            case ENV['BH_ENV']
            when '1'
                base_uri "http://127.0.0.1:4000"
            else
                base_uri "https://id.bithavoc.io"
            end

            public
            attr_reader :app_id

            def initialize(app_id) 
                @app_id = app_id
            end

            def sign_in(email, password)
                res = post('/sign-in', body: {email: email, password: password, password_confirmation: password})
                if res.code == 201
                    auth_code = res['auth_code']
                    return auth_code
                elsif res.code = 422
                    raise IdentityError.new, res['message']
                else
                    raise IdentityError.new, "Something went wrong while validating your credentials"
                end
            end

            def negotiate(auth_code)
                res = self.class.post("/apps/#{app_id}/tokens", body: {code: auth_code})
                puts "Res: #{res}"
                case res.code
                when 201
                    res['token']
                when 422
                    raise IdentityError.new, res['message']
                else
                    raise IdentityError.new, "Something went wrong while validating your credentials"
                end
            end
        end # Client
    end # Identity
end # Bithavoc
