module Bithavoc::Identity::SignIn
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
end
