require 'test_helper'

class QuestionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get question_index_url
    assert_response :success
  end

  test "should get import_csv" do
    get question_import_csv_url
    assert_response :success
  end

end
