if defined? Sidekiq
  redis_url = ENV['REDISTOGO_URL'] || ENV['REDIS_URL']
  Sidekiq.configure_server do |config|
    config.redis = {
      url: redis_url,
      namespace: 'workers',
      size: 2
      }
  end
  Sidekiq.configure_client do |config|
    config.redis = {
      url: redis_url,
      namespace: 'workers',
      size: 1
      }
  end
end