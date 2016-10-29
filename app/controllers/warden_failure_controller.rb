class WardenFailureController < ActionController::Metal
  include AbstractController::Rendering
  include ActionController::ApiRendering
  include ActionController::ConditionalGet
  include ActionController::Renderers::All

  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    if error_message.present?
      render json: { error: error_message }, status: :unauthorized
    else
      head :unauthorized
    end
  end

  private

  def error_message
    @error_message ||= request.env['warden'].message
  end
end
