class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.create_from_oauth(auth)
    create! do |identity|
      identity.provider = auth['provider']
      identity.uid = auth['uid']

      # this seems to be facebook specific?
      identity.oauth_token = auth['credentials']['token'],
      identity.oauth_expires_at = Time.at(auth['credentials']['expires_at'])
    end
  end

  def self.find_from_oauth(auth)
    where(provider: auth['provider'], uid: auth['uid'].to_s).first
  end
end
