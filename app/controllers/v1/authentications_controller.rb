module V1
  class AuthenticationsController < ApiController
    def create
      user = User.find_by(email: email)
      if user.present? && user.authenticate(password)
        render json: user, serializer: AuthenticationSerializer
      else
        render json: { error: "invalid_request" }, status: :bad_request
      end
    end

    private

    def authentication_params
      params.require(:authentication).permit(:email, :password)
    end

    def email
      authentication_params[:email]
    end

    def password
      authentication_params[:password]
    end
  end
end
