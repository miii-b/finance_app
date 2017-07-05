desc "expiration"
task :ultimate_task => :environment do
  puts "set expiration...."
  sessions = Session.where("status= ? AND validity < ?", Session.statuses[:active], Time.now)
  puts sessions.pluck(:id)
  sessions.update_all(status: Session.statuses[:expired]) if sessions.any?
  puts "done."
end
