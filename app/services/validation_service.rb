class ValidationService

  def initialize(rows)
    @rows = rows
  end

  def validate
    validate_rows
    validate_root_user_action
    validate_if_date_is_valid?
  end

  private
  def validate_root_user_action
    if @rows[0].include?("accepts")
      raise Exceptions::InvalidData.new("User must be invited first.")
    end
  end

  def validate_rows
    @rows.each do|row|
      unless row.include?("accepts") || row.include?("recommends")
        raise Exceptions::InvalidData.new("Invitation or recommendation not found.")
      end
    end
  end

  def validate_if_date_is_valid?
    @rows.each do|row|
      date = row[0..15]
      if date.to_datetime > Date.today
        raise Exceptions::InvalidDate.new("User can not be invited with future dates.")
      end
    end
  end

end