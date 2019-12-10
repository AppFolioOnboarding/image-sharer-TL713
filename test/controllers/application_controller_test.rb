require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'root_path returns a 200 response' do
    get root_path

    assert_response :ok
  end

  test 'root_path returns a response with an expected body' do
    get root_path

    assert_includes response.body, 'Hello World!'
  end
end
