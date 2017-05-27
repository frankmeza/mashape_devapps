require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @frank = Developer.create(username: 'frank', email: 'fr@nk.io', password: 'mashape')
    @meza = Developer.create(username: 'meza', email: 'm@za.io', password: 'mashape')

    @frank_new_app = Application.new(developer_id: @frank.id)
    @frank_app1 = Application.create(name: "Fun Stuff", key: 'fun_app', description: 'a good one', developer_id: @frank.id)
    @frank_app2 = Application.create(name: "Fun Stuff", key: 'other_fun_app', description: 'a good one', developer_id: @frank.id)
    @meza_app1 = Application.create(name: "Such Fun Stuff", key: 'such_fun_app', description: 'a good one', developer_id: @meza.id)
  end

  def teardown
    destroy_all Developer
    destroy_all Application
  end

  test 'INDEX - GET /developers/:developer_id/applications' do
    get "/developers/#{@frank.id}/applications"
    assert_equal status, 200
    json = JSON.parse body
    assert_equal json['developer'], @frank.as_json
    json['applications'].include? @frank_app1.as_json
    json['applications'].include? @frank_app2.as_json
    refute json['applications'].include? @meza_app1.as_json
  end

  test 'SHOW - GET /developers/:developer_id/applications/:application_id' do
    get "/developers/#{@frank.id}/applications/#{@frank_app1.id}"
    assert_equal status, 200
    json = JSON.parse body
    assert_equal json['application'], @frank_app1.as_json
  end

  test 'NEW - GET /developers/:developer_id/applications/new' do
    get "/developers/#{@frank.id}/applications/new"
    assert_equal status, 200
    json = JSON.parse body
    assert_equal json['application'], @frank_new_app.as_json
  end

  test 'EDIT - GET /developers/:developer_id/applications/:application_id' do
    get "/developers/#{@frank.id}/applications/#{@frank_app1.id}/edit"
    assert_equal status, 200
    json = JSON.parse body
    assert_equal json['application'], @frank_app1.as_json
  end

  test 'CREATE SUCCESS - POST /developers/:developer_id/applications' do
    valid_app = { name: 'valid', key: 'also_valid', description: 'test', developer_id: @frank.id }
    post "/developers/#{@frank.id}/applications", { application: valid_app }
    assert_equal status, 201
  end

  test 'CREATE ERROR - POST /developers/:developer_id/applications' do
    invalid_app = { name: 'valid', key: 'also_valid', developer_id: @frank.id }
    post "/developers/#{@frank.id}/applications", { application: invalid_app }
    assert_equal status, 422
    json = JSON.parse body
    json['errors']['description'].include? "can't be blank"
  end

  test 'UPDATE SUCCESS - PUT /developers/:developer_id/applications/:application_id' do
    new_name = { name: 'New Name'}
    put "/developers/#{@frank.id}/applications/#{@frank_app1.id}", { application: new_name }
    assert_equal status, 204
  end

  test 'UPDATE ERROR - PUT /developers/:id' do
    no_name = { name: ''}
    put "/developers/#{@frank.id}/applications/#{@frank_app1.id}", { application: no_name }
    assert_equal status, 422
    json = JSON.parse body
    json['errors']['name'].include? "can't be blank"
  end

end