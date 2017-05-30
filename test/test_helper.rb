ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

ActiveSupport::Deprecation.silenced = true

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  def as_json
    JSON.parse self.to_json
  end

  def destroy_all(klass)
    klass.all.each(&:destroy)
  end

  def admin_auth_token
    adm = Admin.create!(email: 'testadmin@yourapp.com', password: 'cloak_and_dagger')
    auth_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhZG1pbl9pZCI6MywiZXhwIjoxNDk2MTY4NjU5fQ.mKO1nhvEUpPTA8JdssEJI4Cc64sGe4kSVoTfqaF32SM'
    { "Authorization": auth_token, "Content-Type": "application/json" }
  end
end
