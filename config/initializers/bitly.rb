Bitly.use_api_version_3

Bitly.configure do |config|
  config.api_version = 3
  config.access_token = ENV["BITLY_GENERIC_ACCESS_TOKEN"]
end
