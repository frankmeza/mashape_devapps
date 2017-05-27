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
    assert response.ok?
    json = JSON.parse body
    json['developers'].include? @frank.as_json
    json['developers'].include? @meza.as_json
  end

  test 'SHOW - GET /developers/:id' do
    get "/developers/#{@frank.id}"
    assert response.ok?
    json = JSON.parse body
    assert_equal json['developer'], @frank.as_json
  end

  test 'NEW - GET /developers/new' do
    get '/developers/new'
    assert response.ok?
    json = JSON.parse body
    assert_equal json['developer'], @new_dev.as_json
  end

  test 'EDIT - GET /developers/:id/edit' do
    get "/developers/#{@frank.id}/edit"
    assert response.ok?
    json = JSON.parse body
    assert_equal json['developer'], @frank.as_json
  end
end
