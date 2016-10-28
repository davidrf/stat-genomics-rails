module Helpers
  module Requests
    delegate :parsed_body, to: :response

    def accept_header(mime_symbol)
      { "Accept" => Mime[mime_symbol].to_s }
    end

    def authorization_headers(mime_symbol, user)
      authentication_token = EncodeJwt.perform(user: user)
      accept_header(mime_symbol).merge(
        "Authorization" => "Token token=#{authentication_token}"
      )
    end
  end
end
