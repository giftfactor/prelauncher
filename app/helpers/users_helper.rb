module UsersHelper

  TWITTER_SHARE_URL = 'http://twitter.com/share'
  FACEBOOK_SHARE_URL = 'http://www.facebook.com/sharer/sharer.php'

  def tweet_link(message, referral_code = @user.referral_code)
    url = CGI::escape referral_url(referral_code)
    text = CGI::escape message
    link_to("#{TWITTER_SHARE_URL}?url=#{url}&text=#{text}".html_safe, class: 'twit', target: '_blank') { 'Share on Twitter' }
  end

  def fb_link(message, referral_code = @user.referral_code)
    url = CGI::escape referral_url(referral_code)
    text = CGI::escape message
    link_to("#{FACEBOOK_SHARE_URL}?u=#{url}&title=#{text}".html_safe, class: 'fb', target: '_blank') { 'Share on Facebook' }
  end

  def referral_url(referral_code = @user.referral_code)
    "#{root_url}?ref_code=#{referral_code}"
  end
end
