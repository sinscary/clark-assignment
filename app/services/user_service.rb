class UserService
  include ActiveModel::Model
  
  attr_accessor :name, :referrer, :invited_at, :invite_accepted, :reward_points

  validates :name, :invited_at, presence: true

  def initialize(name, invite_accepted, invited_at, referrer=nil)
    @name = name
    @invite_accepted = invite_accepted
    @referrer = referrer
    @invited_at = invited_at
    @reward_points = 0.0
  end

end