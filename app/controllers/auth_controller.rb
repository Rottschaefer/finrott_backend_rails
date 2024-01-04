class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login]

    def login

        if !!current_user 
            
            @token = encode_token(current_user[:email])
            render json: {id: current_user[:id], name: current_user[:name], email: current_user[:email], token: @token}, status: :accepted
            
        else
            @user = User.find_by!(email: login_params["email"])
        

            if @user.authenticate(login_params[:password])
                @token = encode_token(login_params[:email])
    
                render json: {id: @user.id, name: @user.name, email: @user.email, token: @token}, status: :accepted
            else
                render json: {message: 'Incorrect password'}, status: :unauthorized
            end
        end
        end



    def get_connect_token
        pluggyApiKey = get_pluggy_key()

        connectToken = get_pluggy_connect_token(pluggyApiKey)

        render json: {connectToken: connectToken}
    end

    private

    def login_params
        params.require(:auth).permit(:email, :password)
    end
end
