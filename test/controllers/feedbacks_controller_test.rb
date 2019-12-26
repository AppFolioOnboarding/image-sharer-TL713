require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'new_feeedback_path returns a 200 response' do
    get new_feedback_path
    assert_response :ok
    assert_select '#feedback-root', count: 1
  end
end
