require 'sidekiq'
Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

# We'll configure the Sidekiq server as well

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

class ExpirationWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform
    debugger
    sessions = Session.where("status= ? AND validity < ?", Session.statuses[:active], Time.now)
    sessions.update_all(status: Session.statuses[:expired]) if sessions.any?
  end
end