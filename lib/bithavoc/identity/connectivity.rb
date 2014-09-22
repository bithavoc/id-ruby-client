require "httparty"

module Bithavoc::Identity::Connectivity

    def self.included(kclass)
        kclass.class_eval do
            include HTTParty
            case ENV['BH_ENV']
            when '1'
                kclass.base_uri "http://127.0.0.1:4000"
            else
                kclass.base_uri "https://id.bithavoc.io"
            end
        end
    end

end
