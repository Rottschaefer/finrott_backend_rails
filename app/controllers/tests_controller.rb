require "http"

class TestsController < ApplicationController
    skip_before_action :authorized

    def test

    accountId = params[:accountId]
    
    apiKey =  get_pluggy_key

    config = {"X-API-KEY" => apiKey}

    response = JSON.parse(HTTP.headers(config).get("https://api.pluggy.ai/transactions?accountId=#{accountId}").body)

    p response
        # response = HTTP.post("https://api.pluggy.ai/transactions?accountId=#{accountId}", :json => body)

        # render json: {response: JSON.parse(response.body)["apiKey"]}
    end

end
