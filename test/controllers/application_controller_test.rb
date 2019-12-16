require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'root_path returns a 200 response with a expected body' do
    get root_path

    assert_response :ok
    assert_includes response.body, 'Image Index'
  end
end
