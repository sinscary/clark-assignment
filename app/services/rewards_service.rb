class RewardsService

  RATIO_COEFFICIENT = 2.0

  def initialize(mapped_data)
    @mapped_data = mapped_data
  end

  def calculate_rewards
    @mapped_data.keys.each do|user_node|
      reward_points = 1
      calculate(user_node, reward_points)
    end
    @mapped_data
  end

  private
  def calculate(user_node, reward_points)
    user = @mapped_data[user_node]
    referrer = @mapped_data[user.referrer]
    return if referrer.blank?
    referrer.reward_points += reward_points
    reward_points /= RATIO_COEFFICIENT
    calculate(user.referrer, reward_points)
  end

end