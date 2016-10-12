class EncodeJwt
  attr_reader :user

  def self.perform(argument)
    new(argument).perform
  end

  def initialize(user:)
    @user = user
  end

  def perform
    JWT.encode payload, token_secret, "HS256"
  end

  private

  def payload
    {
      "sub": user.id,
      "exp": access_token_duration_in_days.days.from_now.to_i
    }
  end

  def access_token_duration_in_days
    ENV.fetch("ACCESS_TOKEN_DURATION_IN_DAYS", "7").to_i
  end

  def token_secret
    Rails.application.secrets.secret_key_base
  end
end
