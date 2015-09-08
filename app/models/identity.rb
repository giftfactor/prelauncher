class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.create_from_oauth(auth)
    create! do |identity|
      identity.provider = auth['provider']
      identity.uid = auth['uid']
    end
  end

  def self.find_from_oauth(auth)
    where(provider: auth['provider'], uid: auth['uid'].to_s).first
  end
end
