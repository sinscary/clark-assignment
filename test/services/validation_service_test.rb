require 'test_helper'

class ValidationServiceTest < ActiveSupport::TestCase
  test "should raise error if accepts without invitation" do
    data = File.read(Rails.root.join('test/fixtures/files/data.txt'))
    data = data.split(/\n/)
    data.shift
    error = assert_raises Exceptions::InvalidData do
      ValidationService.new(data).validate
    end
    assert_equal error.message, "User must be invited first."
  end

  test "should raise error if rows doesn't contain accpets or recommends" do
    data = File.read(Rails.root.join('test/fixtures/files/data.txt'))
    data = data.gsub("accepts", "").split(/\n/)
    error = assert_raises Exceptions::InvalidData do
      ValidationService.new(data).validate
    end
    assert_equal error.message, "Invitation or recommendation not found."
  end
end