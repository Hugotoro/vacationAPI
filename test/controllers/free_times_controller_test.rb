require "test_helper"

class FreeTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @free_time = free_times(:one)
  end

  test "should get index" do
    get free_times_url, as: :json
    assert_response :success
  end

  test "should create free_time" do
    assert_difference("FreeTime.count") do
      post free_times_url, params: { free_time: { employee_id: @free_time.employee_id, end_date: @free_time.end_date, leader: @free_time.leader, leave_type: @free_time.leave_type, reason: @free_time.reason, start_date: @free_time.start_date, state: @free_time.state } }, as: :json
    end

    assert_response :created
  end

  test "should show free_time" do
    get free_time_url(@free_time), as: :json
    assert_response :success
  end

  test "should update free_time" do
    patch free_time_url(@free_time), params: { free_time: { employee_id: @free_time.employee_id, end_date: @free_time.end_date, leader: @free_time.leader, leave_type: @free_time.leave_type, reason: @free_time.reason, start_date: @free_time.start_date, state: @free_time.state } }, as: :json
    assert_response :success
  end

  test "should destroy free_time" do
    assert_difference("FreeTime.count", -1) do
      delete free_time_url(@free_time), as: :json
    end

    assert_response :no_content
  end
end
