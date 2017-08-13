require 'test_helper'

class DevelopersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @frank = create(:developer)
  end

  def after_setup
    @admin_headers = include_admin_auth_token
  end

  def teardown
    destroy_all Application
    destroy_all Developer
    destroy_all Admin
  end

  test 'INDEX - GET /developers' do
    meza = create(:developer)

    get '/developers',
      headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    json['developers'].any? do |dev|
      assert dev['email'] == @frank.email || dev['email'] == @meza.email
    end
  end

  test 'SHOW - GET /developers/:id' do
    get "/developers/#{@frank.id}",
      headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    assert_equal json['developer']['email'], @frank.email
  end

  test 'CREATE SUCCESS - POST /developers' do
    valid_dev = build(:developer)

    post '/developers',
      params: { developer: valid_dev.attributes },
      headers: @admin_headers
    assert_equal 201, status
  end

  test 'CREATE ERROR - POST /developers' do
    dev_without_email = build(:developer, email: nil)

    post '/developers',
      params: { developer: dev_without_email.attributes },
      headers: @admin_headers
    assert_equal 422, status
    json = JSON.parse body
    json['errors']['email'].include? "can't be blank"
  end

  test 'UPDATE SUCCESS - PUT /developers/:id' do
    new_name = { username: 'Frankyboy' }

    put "/developers/#{@frank.id}",
      params: { developer: new_name },
      headers: @admin_headers
    assert_equal 204, status
  end

  test 'UPDATE ERROR - PUT /developers/:id' do
    no_name = { username: '' }

    put "/developers/#{@frank.id}",
      params: { developer: no_name },
      headers: @admin_headers
    assert_equal 422, status
    json = JSON.parse body
    json['errors']['username'].include? "can't be blank"
  end

  test 'DELETE - DELETE /developers/:id' do
    delete "/developers/#{@frank.id}",
      headers: @admin_headers
    assert_equal 204, status
    assert_nil Developer.find_by(username: 'frank')
  end
end
