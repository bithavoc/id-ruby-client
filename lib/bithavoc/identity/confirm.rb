
module Bithavoc::Identity::Confirm

    def confirm(email_code)
        res = self.class.post("/apps/#{app_id}/confirm", body: {code: email_code})
        case res.code
        when 200
            res['auth_code']
        when 422
            raise Bithavoc::Identity::IdentityError.new, res['message']
        else
            raise Bithavoc::Identity::IdentityError.new, "Something went wrong while confirming your email"
        end
    end

end
