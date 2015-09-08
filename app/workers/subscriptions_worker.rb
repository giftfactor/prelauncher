class SubscriptionsWorker
  include SuckerPunch::Job

  def perform(user_id)
    user = User.find user_id
    gibbon = Gibbon::Request.new
    payload = {
      body: {
        email_address: user.email,
        status: 'subscribed',
        merge_fields: {
          FNAME: user.first_name,
          LNAME: user.last_name
        }
      }
    }
    Rails.logger.debug payload

    begin
      gibbon.lists(ENV['GIBBON_LIST_ID']).members.create(payload)
    rescue Gibbon::MailChimpError => e
      Rails.logger.error e.message
      Rails.logger.error e.title
      Rails.logger.error e.detail
      Rails.logger.error e.body
    end
  end
end
