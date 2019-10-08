require 'test_helper'

class RewardsServiceTest < ActiveSupport::TestCase

  test "calculate rewards for each referrer" do
    data = File.read(Rails.root.join('test/fixtures/files/data.txt'))
    data = data.split(/\n/)
    user_mapper = UserRewardMapper.new(data).build_map
    rewards_service = RewardsService.new(user_mapper)
    result = rewards_service.calculate_rewards
    assert_equal result["A"].reward_points, 1.75
    assert_equal result["B"].reward_points, 1.5
    assert_equal result["C"].reward_points, 1.0
  end

end