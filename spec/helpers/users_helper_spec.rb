require "rails_helper"

RSpec.describe UsersHelper, :type => :helper do
  let(:host) { 'http://test.host/' }
  let(:referral_code) { 'abcd1234' }
  let(:url) { CGI::escape "#{host}?ref_code=#{referral_code}" }
  let(:message) { 'message' }

  describe "#referral_url" do
    it 'returns the referral url for sharing' do
      expect(helper.referral_url(referral_code)).to eq("http://test.host/?ref_code=#{referral_code}")
    end
  end

  describe "#tweet_link" do
    let(:share_url) { 'http://twitter.com/share' }
    it "returns a twitter link" do
      href = "#{share_url}?url=#{url}&text=#{message}"
      expect(helper.tweet_link(referral_code, message)).to eq("<a class=\"twit\" target=\"_blank\" href=\"#{href}\"></a>")
    end
  end

  describe "#fb_link" do
    let(:share_url) { 'http://www.facebook.com/sharer/sharer.php' }
    it "returns an fb link" do
      href = "#{share_url}?u=#{url}&title=#{message}"
      expect(helper.fb_link(referral_code, message)).to eq("<a class=\"fb\" target=\"_blank\" href=\"#{href}\"></a>")
    end
  end

end
