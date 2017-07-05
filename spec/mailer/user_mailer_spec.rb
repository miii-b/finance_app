require 'rails_helper'

describe UserMailer do
  describe 'reset_of_password' do
    let(:user) { create :user}
    let(:email) { UserMailer.notification_email(user) }

    it 'renders the sender email' do
      expect(email.from).to eql(['finance_app_notification@example.com'])
    end

    it 'renders the subject' do
      expect(email.subject).to eql('Critical value')
    end

    it 'renders the receiver email' do
      expect(email.to).to eql([user.name])
    end

  end
end