module Bithavoc::Identity::SignUp
    SIGNUP_PASSTHROUGH=['email', 'fullname', 'password']
    def sign_up(options)
        options = Hash[(options.select {|k,v| SIGNUP_PASSTHROUGH.include?(k.to_s) }.merge!({:password_confirmation=> options['password'] || options[:password]})).sort]
        res = self.class.post("/apps/#{app_id}/sign-up", body: options)
        case res.code
        when 200
            nil
        when 422
            raise Bithavoc::Identity::IdentityError.new, res['message']
        else
            raise Bithavoc::Identity::IdentityError.new, "Something went wrong while validating your credentials"
        end
    end
end
