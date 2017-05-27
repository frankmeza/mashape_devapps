require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @frank = Developer.create(username: 'frank', email: 'fr@nk.io', password: 'mashape')
    @meza = Developer.create(username: 'meza', email: 'm@za.io', password: 'mashape')

    @frank_app1 = Application.create(name: "Fun Stuff", key: 'fun_app', description: 'a good one', developer_id: @frank.id)
    @frank_app2 = Application.create(name: "Fun Stuff", key: 'fun_app', description: 'a good one', developer_id: @frank.id)
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
  end
end
