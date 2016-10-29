Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.failure_app = WardenFailureController
end

Warden::Strategies.add(
  :access_token_authenticatable,
  Strategies::AccessTokenAuthenticatable
)
