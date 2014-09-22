
module Bithavoc::Identity::Negotiate

    def negotiate(auth_code)
        res = self.class.post("/apps/#{app_id}/tokens", body: {code: auth_code})
        case res.code
        when 201
            res
        when 422
            raise Bithavoc::Identity::IdentityError.new, res['message']
        else
            raise Bithavoc::Identity::IdentityError.new, "Something went wrong while validating your credentials"
        end
    end

end
