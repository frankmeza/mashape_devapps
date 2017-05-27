require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  setup do
    @frank = Developer.new(username: 'frank', email: 'fr@nk.io', password: 'mashape')
  end

  teardown do
    @frank.destroy
  end

  test 'a valid Developer has a username, email address, and password' do
    assert @frank.valid?
  end

  test 'a Developer requires a username' do
    @frank.username = nil
    assert_not @frank.valid?
  end

  test 'a Developer requires an email address' do
    @frank.email = nil
    assert_not @frank.valid?
  end

  test 'a Developer requires a password' do
    @frank.password = nil
    assert_not @frank.valid?
  end
end
