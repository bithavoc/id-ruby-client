module Bithavoc::Identity::SignIn
    def sign_in(email, password)
        res = self.class.post("/apps/#{app_id}/sign-in", body: {email: email, password: password, password_confirmation: password})
        case res.code
        when 200
            res['auth_code']
        when 422
            raise Bithavoc::Identity::IdentityError.new, res['message']
        else
            raise Bithavoc::Identity::IdentityError.new, "Something went wrong while validating your credentials"
        end
    end
end
