require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

class ExpirationWorker
  # set expiration automatically after 5 minuts
  include Sidekiq::Worker
  sidekiq_options queue: 'high'
  # sidekiq_options retry: false
  
  def perform
    sessions = Session.where('status= ? AND validity < ?', Session.statuses[:active], Time.now)
    sessions.update_all(status: Session.statuses[:expired]) if sessions.any?
  end
end
