module Helpers
  module Requests
    delegate :parsed_body, to: :response

    def accept_header_v1
      { "Accept" => Mime[:v1].to_s }
    end

    def authorization_headers(mime_symbol, authentication_token)
      accept_header(mime_symbol).merge(
        "Authorization" => "Token token=#{authentication_token}"
      )
    end
  end
end
