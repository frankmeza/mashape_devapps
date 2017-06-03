require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  setup do
    @application = create(:application)
  end

  teardown do
    destroy_all Application
    destroy_all Developer
  end

  test 'a valid Application has a name, key, description, and developer_id' do
    assert @application.valid?
  end

  test 'an Application requires a name' do
    @application.name = nil
    assert_not @application.valid?
  end

  test 'an Application requires a key' do
    @application.key = nil
    assert_not @application.valid?
  end

  test 'an Application requires a description' do
    @application.description = nil
    assert_not @application.valid?
  end

  test 'an Application requires a developer' do
    @application.developer_id = nil
    assert_not @application.valid?
  end
end
