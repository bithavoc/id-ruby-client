
module Bithavoc::Identity::Validate

    def validate(token)
        res = self.class.get("/apps/#{app_id}/tokens/#{token}")
        case res.code
        when 200
            res['user']
        when 403
            raise Bithavoc::Identity::IdentityError.new, res['message']
        else
            raise Bithavoc::Identity::IdentityError.new, "Something went wrong while confirming your email"
        end
    end

end
