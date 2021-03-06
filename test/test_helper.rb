ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...
  def as_json
    JSON.parse self.to_json
  end

  def destroy_all(klass)
    klass.all.each(&:destroy)
  end

  def include_admin_auth_token
    admin = create(:admin)
    post '/authenticate', params: { "email": admin.email, "password": admin.password }
    response = JSON.parse body
    { "Authorization": response["auth_token"] }
  end
end
