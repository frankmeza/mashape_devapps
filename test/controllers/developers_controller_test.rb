require 'test_helper'

class DevelopersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @new_dev = Developer.new()
    @frank = Developer.create username: 'frank', email: 'fr@nk.io', password: 'mashape'
    @meza = Developer.create username: 'meza', email: 'm@za.io', password: 'mashape'
  end

  def teardown
    destroy_all Developer
  end

  test 'INDEX - GET /developers' do
    get '/developers'
    assert_equal status, 200
    json = JSON.parse body
    json['developers'].include? @frank.as_json
    json['developers'].include? @meza.as_json
  end

  test 'SHOW - GET /developers/:id' do
    get "/developers/#{@frank.id}"
    assert_equal status, 200
    json = JSON.parse body
    assert_equal json['developer'], @frank.as_json
  end

  test 'NEW - GET /developers/new' do
    get '/developers/new'
    assert_equal status, 200
    json = JSON.parse body
    assert_equal json['developer'], @new_dev.as_json
  end

  test 'EDIT - GET /developers/:id/edit' do
    get "/developers/#{@frank.id}/edit"
    assert_equal status, 200
    json = JSON.parse body
    assert_equal json['developer'], @frank.as_json
  end

  test 'CREATE SUCCESS - POST /developers' do
    valid_dev = { username: 'dev', email: 'dev@email.com', password: 'devdevdev' }
    post '/developers', { developer: valid_dev }
    assert_equal status, 201
  end

  test 'CREATE ERROR - POST /developers' do
    dev_without_email = { username: 'dev', password: 'devdevdev' }
    post '/developers', { developer: dev_without_email }
    assert_equal status, 422
  end
end
