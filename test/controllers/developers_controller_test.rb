require 'test_helper'

class DevelopersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @frank = Developer.create(username: 'frank', email: 'fr@nk.io', password: 'mashape')
    @admin = Admin.create!(email: 'testadmin@yourapp.com', password: 'cloak_and_dagger')
  end

  def after_setup
    @admin_headers = include_admin_auth_token
  end

  def teardown
    destroy_all Developer
    destroy_all Admin
  end

  test 'INDEX - GET /developers' do
    meza = Developer.create(username: 'meza', email: 'm@za.io', password: 'mashape')

    get '/developers', headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    json['developers'].include? @frank.as_json
    json['developers'].include? meza.as_json
  end

  test 'SHOW - GET /developers/:id' do
    get "/developers/#{@frank.id}", headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    assert_equal json['developer'], @frank.as_json
  end

  test 'NEW - GET /developers/new' do
    new_dev = Developer.new()

    get '/developers/new', headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    assert_equal json['developer'], new_dev.as_json
  end

  test 'EDIT - GET /developers/:id/edit' do
    get "/developers/#{@frank.id}/edit", headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    assert_equal json['developer'], @frank.as_json
  end

  test 'CREATE SUCCESS - POST /developers' do
    valid_dev = { username: 'dev', email: 'dev@email.com', password: 'devdevdev' }

    post '/developers', params: { developer: valid_dev }, headers: @admin_headers
    assert_equal 201, status
  end

  test 'CREATE ERROR - POST /developers' do
    dev_without_email = { username: 'dev', password: 'devdevdev' }

    post '/developers', params: { developer: dev_without_email }, headers: @admin_headers
    assert_equal 422, status
    json = JSON.parse body
    json['errors']['email'].include? "can't be blank"
  end

  test 'UPDATE SUCCESS - PUT /developers/:id' do
    new_name = { username: 'Frankyboy' }

    put "/developers/#{@frank.id}", params: { developer: new_name }, headers: @admin_headers
    assert_equal 204, status
  end

  test 'UPDATE ERROR - PUT /developers/:id' do
    no_name = { username: '' }

    put "/developers/#{@frank.id}", params: { developer: no_name }, headers: @admin_headers
    assert_equal 422, status
    json = JSON.parse body
    json['errors']['username'].include? "can't be blank"
  end

  test 'DELETE - DELETE /developers/:id' do
    delete "/developers/#{@frank.id}", headers: @admin_headers
    assert_equal 204, status
    assert_nil Developer.find_by(username: 'frank')
  end
end
