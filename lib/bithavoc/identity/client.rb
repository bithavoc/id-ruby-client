require "bithavoc/identity/version"
require "bithavoc/identity/error"

require "bithavoc/identity/connectivity"
Dir.glob( File.join( File.dirname(__FILE__), 'operations', '*.rb' ), &method(:require) )

module Bithavoc
    module Identity
        class Client
            include Connectivity

            include Negotiate
            include SignIn
            include SignUp
            include Confirm
            include Validate

            attr_reader :app_id

            def initialize(app_id) 
                @app_id = app_id
            end

        end
    end
end
