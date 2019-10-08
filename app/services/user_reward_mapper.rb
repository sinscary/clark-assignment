class UserRewardMapper
  include ActiveModel::Model
  def initialize(rows)
    @rows = rows
    @user_reward_map = {}
  end

  def build_map
    @rows.each do|row|
      row_data = row.split(" ")
      map_users_and_rewards(row_data)
    end
    return @user_reward_map
  end

  private
  def map_users_and_rewards(row_data)
    if @user_reward_map.blank? || row_data.include?("recommends")
      create_new_user_reward_mapping(row_data)
    else
      update_existing_user_reward_mapping(row_data)
    end
  end

  def create_new_user_reward_mapping(row_data)
    if @user_reward_map.blank?
      create_root_level_mapping(row_data)
    end
    referrer = @user_reward_map.present? && row_data.include?("recommends") ? row_data[2] : nil
    invited_at = row_data[0..1].join(" ").to_datetime
    return if user_is_already_invited?(row_data, invited_at)
    user = UserService.new(
      row_data[4], false, invited_at, referrer
    )
    if user.valid?
      @user_reward_map[user.name] = user
    else
      raise Exceptions::InvalidRecord.new(user.errors.full_messages.join(', '))
    end
  end

  def create_root_level_mapping(row_data)
    invited_at = row_data[0..1].join(" ").to_datetime
    user = UserService.new(
      row_data[2], true, invited_at, nil
    )
    if user.valid?
      @user_reward_map[user.name] = user
    else
      raise Exceptions::InvalidRecord.new(user.errors.full_messages.join(', '))
    end
  end

  def update_existing_user_reward_mapping(row_data)
    user = @user_reward_map[row_data[2]]
    user.invite_accepted = true
    @user_reward_map[row_data[2]] = user
  end

  def user_is_already_invited?(row_data, invited_at)
    invited_user = @user_reward_map[row_data[4]]
    invited_user.present? && invited_user.invited_at < invited_at
  end
end