require 'test_helper'

class UserRewardMapperTest < ActiveSupport::TestCase

  test "should raise error if accepts without invitation" do
    data = File.read(Rails.root.join('test/fixtures/files/data.txt'))
    data = data.split(/\n/)
    data.shift
    error = assert_raises Exceptions::InvalidData do
      UserRewardMapper.new(data).build_map
    end
    assert_equal error.message, "User must be invited first."
  end

  test "should only accept first invitation" do
    # In test fixture both B and C invite D
    # C invites first hence only C is eligible for rewards
    data = File.read(Rails.root.join('test/fixtures/files/data.txt'))
    data = data.split(/\n/)
    user_mapper = UserRewardMapper.new(data).build_map
    assert_equal user_mapper["D"].referrer, "C"
  end

  test "should raise error if name is not present" do
    data = File.read(Rails.root.join('test/fixtures/files/data.txt'))
    data = [data.split(/\n/).shift.delete_suffix!('B')]
    error = assert_raises Exceptions::InvalidRecord do
      UserRewardMapper.new(data).build_map
    end
    assert_equal error.message, "Name can't be blank"
  end

end