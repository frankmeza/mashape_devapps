require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  setup do
    @frank = Admin.new(email: 'adminfr@nk.io', password: 'mashape')
  end

  teardown do
    @frank.destroy
  end

  test 'a valid Admin has a email address, and password' do
    assert @frank.valid?
  end

  test 'an Admin requires an email address' do
    @frank.email = nil
    assert_not @frank.valid?
  end

  test 'an Admin requires a password' do
    @frank.password = nil
    assert_not @frank.valid?
  end
end
