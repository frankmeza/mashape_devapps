require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  test 'a valid Developer has a username, email address, and password' do
    frank = Developer.new(username: 'frank', email: 'frank@computerblue.com', password: 'california2017')
    assert frank.valid?
  end

  test 'a Developer requires a username' do
    frank = Developer.new(email: 'frank@computerblue.com', password: 'california2017')
    assert_not frank.valid?
  end

  test 'a Developer requires an email address' do
    frank = Developer.new(username: 'frank', password: 'california2017')
    assert_not frank.valid?
  end

  test 'a Developer requires a password' do
    frank = Developer.new(username: 'frank', email: 'frank@computerblue.com')
    assert_not frank.valid?
  end
end
