if Rails.env.production?
  Rails.application.config.middleware.use(Rack::Tracker) do
    handler :google_analytics, {
      tracker: ENV['GOOGLE_ANALYTICS_ID'],
      enhanced_link_attribution: true,
      advertising: true
    }
  end
end
