require "http"

class TestsController < ApplicationController
    skip_before_action :authorized

    def test


    
        body = {
            clientId: ENV['CLIENT_ID'],
            clientSecret: ENV['CLIENT_SECRET']
        }

        response = HTTP.post("https://api.pluggy.ai/auth", :json => body)

        render json: {response: JSON.parse(response.body)["apiKey"]}
    end

end
