class AuthenticatedConstraint
  def matches?(request)
    warden = request.env["warden"]
    warden && warden.authenticate!(:access_token_authenticatable)
  end
end
