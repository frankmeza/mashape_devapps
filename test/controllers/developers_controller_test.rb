require 'test_helper'

class DevelopersControllerTest < ActionDispatch::IntegrationTest
  test 'GET /developers' do
    get '/developers'
    assert response.ok?
  end
end
