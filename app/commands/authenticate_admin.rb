class AuthenticateAdmin
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(admin_id: admin.id) if admin
  end


  private


  attr_accessor :email, :password

  def admin
    admin = Admin.find_by(email: email)
    return admin if admin && admin.authenticate(password)

    errors.add(:admin_authentication, 'Sorry, those credentials are not valid.')
  end
end
