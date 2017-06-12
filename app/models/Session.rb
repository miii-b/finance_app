class Session < ActiveRecord::Base
  belongs_to :user

  enum status: [:active, :logged_out, :force_logged_out, :expired]

  SESSION_VALIDITY = 5.minutes
end