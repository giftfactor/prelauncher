class User < ActiveRecord::Base
  has_many :identities

  validates_format_of :email, with: /.+@.+\..+/i
  validates_uniqueness_of :email
  validates_uniqueness_of :referral_code

  default_scope { order(created_at: :desc) }

  has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"
  belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"

  before_create :generate_referral_code

  def add_referral(email)
    user = User.where(email: email).first
    if user
      self.referrals << user
      user.referrer = self
    end
  end

  def generate_referral_code
    self.referral_code = SecureRandom.hex(5)
  end

end
