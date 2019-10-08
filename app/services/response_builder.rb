class ResponseBuilder


  def self.success(mapped_data)
    response = {}
    mapped_data.each do|user_name, user|
      if user.reward_points.present? && user.reward_points > 0
        response[user_name] = user.reward_points
      end
    end
    response
  end

  def self.error(msg)
    {
      error: msg
    }
  end

end