require 'test_helper'

class RewardsControllerTest < ActionDispatch::IntegrationTest
  
  test "should upload rewards file and return rewards by user" do
    file = fixture_file_upload(Rails.root.join('test/fixtures/files/data.txt'), 'text/plain')
    post '/process_rewards', 
          params: { data: file }, 
          headers: { 'content-type': 'text/plain' }
    result = JSON.parse(response.body)
    assert_equal response.status, 200
    assert_equal result["A"], 1.75
    assert_equal result["B"], 1.5
    assert_equal result["C"], 1.0
  end

  test "should return error if empty file is uploaded" do
    file = fixture_file_upload(Rails.root.join('test/fixtures/files/empty_data.txt'), 'text/plain')
    post '/process_rewards', 
          params: { data: file }, 
          headers: { 'content-type': 'text/plain' }
    result = JSON.parse(response.body)
    assert_equal result["error"], "File must contain some data."
  end

  test "should fail if no file is provided" do
    post '/process_rewards'
    result = JSON.parse(response.body)
    assert_equal result["error"], "Please provide a valid file."
  end

end