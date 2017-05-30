class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    admin
  end


  private


  attr_reader :headers

  def admin
    @admin ||= Admin.find(decoded_auth_token[:admin_id]) if decoded_auth_token
    @admin ||= errors.add(:token, 'Sorry, that auth token is incorrect.') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Sorry, the auth token is missing.')
    end
    nil
  end
end