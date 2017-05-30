require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @frank = Developer.create(username: 'frank', email: 'fr@nk.io', password: 'mashape')
    @frank_app1 = Application.create(name: "Fun Stuff", key: 'fun_app', description: 'a good one', developer_id: @frank.id)
    @admin = Admin.create!(email: 'testadmin@yourapp.com', password: 'cloak_and_dagger')
  end

  def after_setup
    post '/authenticate', { "email": @admin.email, "password": @admin.password }
    response = JSON.parse body
    @admin_headers = { "Authorization": response["auth_token"] }
  end

  def teardown
    destroy_all Developer
    destroy_all Application
  end

  test 'INDEX - GET /developers/:developer_id/applications' do
    frank_app2 = Application.create(name: "Fun Stuff", key: 'other_fun_app', description: 'a good one', developer_id: @frank.id)
    meza = Developer.create(username: 'meza', email: 'm@za.io', password: 'mashape')
    meza_app1 = Application.create(name: "Such Fun Stuff", key: 'such_fun_app', description: 'a good one', developer_id: meza.id)

    get "/developers/#{@frank.id}/applications", headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    assert_equal json['developer'], @frank.as_json
    json['applications'].include? @frank_app1.as_json
    json['applications'].include? frank_app2.as_json
    refute json['applications'].include? meza_app1.as_json
  end

  test 'SHOW - GET /developers/:developer_id/applications/:application_id' do
    get "/developers/#{@frank.id}/applications/#{@frank_app1.id}", headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    assert_equal json['application'], @frank_app1.as_json
  end

  test 'NEW - GET /developers/:developer_id/applications/new' do
    frank_new_app = Application.new(developer_id: @frank.id)

    get "/developers/#{@frank.id}/applications/new", headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    assert_equal json['application'], frank_new_app.as_json
  end

  test 'EDIT - GET /developers/:developer_id/applications/:application_id' do
    get "/developers/#{@frank.id}/applications/#{@frank_app1.id}/edit", headers: @admin_headers
    assert_equal 200, status
    json = JSON.parse body
    assert_equal json['application'], @frank_app1.as_json
  end

  test 'CREATE SUCCESS - POST /developers/:developer_id/applications' do
    valid_app = { name: 'valid', key: 'also_valid', description: 'test', developer_id: @frank.id }
    post "/developers/#{@frank.id}/applications", params: { application: valid_app }, headers: @admin_headers
    assert_equal 201, status
  end

  test 'CREATE ERROR - POST /developers/:developer_id/applications' do
    invalid_app = { name: 'valid', key: 'also_valid', developer_id: @frank.id }
    post "/developers/#{@frank.id}/applications", params: { application: invalid_app }, headers: @admin_headers
    assert_equal 422, status
    json = JSON.parse body
    json['errors']['description'].include? "can't be blank"
  end

  test 'UPDATE SUCCESS - PUT /developers/:developer_id/applications/:application_id' do
    new_name = { name: 'New Name'}
    put "/developers/#{@frank.id}/applications/#{@frank_app1.id}", params: { application: new_name }, headers: @admin_headers
    assert_equal 204, status
  end

  test 'UPDATE ERROR - PUT /developers/:developer_id/applications/:application_id' do
    no_name = { name: ''}
    put "/developers/#{@frank.id}/applications/#{@frank_app1.id}", params: { application: no_name }, headers: @admin_headers
    assert_equal 422, status
    json = JSON.parse body
    json['errors']['name'].include? "can't be blank"
  end

  test 'DELETE - DELETE /developers/:developer_id/applications/:application_id' do
    delete "/developers/#{@frank.id}/applications/#{@frank_app1.id}", headers: @admin_headers
    assert_equal status, 204
    assert_nil Application.find_by id: @frank_app1.id
  end
end
