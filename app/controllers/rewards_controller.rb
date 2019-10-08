class RewardsController < ApplicationController
  before_action :ensure_data_is_present

  def process_rewards
    parser = DataParsingService.new(params[:data])
    rows = parser.parse
    mapped_data = UserRewardMapper.new(rows).build_map
    result = RewardsService.new(mapped_data).calculate_rewards
    render json: ResponseBuilder.success(result)
  rescue StandardError => e
    binding.pry
    render json: ResponseBuilder.error(e.message)
  end

  private
  def ensure_data_is_present
    unless params[:data].present? && params[:data].content_type.include?("text")
      render json: ResponseBuilder.error("Please provide a valid file.")
    end
  end

end