class ApplicationController < ActionController::API

    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, ENV['JWT_KEY']) 
    end

    def decoded_token
        header = request.headers['Authorization']
        
        if header
            token = header.split(" ")[1]
            begin
                JWT.decode(header, ENV['JWT_KEY'])
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user 
        if decoded_token
            user_email = decoded_token[0]
            @user = User.find_by(email: user_email)
        end
    end

    def authorized
        unless !!current_user
        render json: { message: 'Please log in' }, status: :unauthorized
        end
    end

    def get_pluggy_key
        
        body = {
            clientId: ENV['CLIENT_ID'],
            clientSecret: ENV['CLIENT_SECRET']
        }

        response = HTTP.post("https://api.pluggy.ai/auth", :json => body)

        JSON.parse(response.body)["apiKey"]
    end

    def get_pluggy_connect_token(pluggyApiKey)

        config = {"X-API-KEY" => pluggyApiKey}
        JSON.parse(HTTP.headers(config).post("https://api.pluggy.ai/connect_token").body)["accessToken"]
    end

end
