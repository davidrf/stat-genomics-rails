module V1
  class UsersController < ApiController
    def create
      user = User.new(user_params)
      if user.save
        render(
          json: user,
          status: :created,
          location: user,
          serializer: AuthenticationSerializer
        )
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params
        .require(:user)
        .permit(:email, :password)
        .merge({
          root_directory_entry_attributes: {
            name: "Home Folder"
          }
        })
    end
  end
end
