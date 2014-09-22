require "bithavoc/identity/version"
require "bithavoc/identity/error"

# operations
require "bithavoc/identity/connectivity"
require "bithavoc/identity/negotiate"
require "bithavoc/identity/signin"
require "bithavoc/identity/signup"

module Bithavoc
    module Identity
        class Client
            include Connectivity

            include Negotiate
            include SignIn
            include SignUp

            public
            attr_reader :app_id

            def initialize(app_id) 
                @app_id = app_id
            end

        end # Client
    end # Identity
end # Bithavoc
