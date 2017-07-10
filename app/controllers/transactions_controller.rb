class TransactionsController < ApplicationController
  before_action :require_user
  
  def show
    account = Account.find(params[:id])
    @transactions = account.transactions.order(prepare_sort_params)
  end

  def new
    @transaction = Transaction.new
    if current_user.accounts.blank?
      flash[:danger] = 'You have to create account first'
      redirect_to new_account_path
    end
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      update_balance(@transaction.account_id, @transaction.amount)
      check_critical
      redirect_to accounts_path, notice: 'Transaction was successfully created'
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:user_id, :category_id, :account_id, :purpose, :amount)
  end

  def check_critical
    user = User.find(transaction_params[:user_id])
    account = user.accounts.find(transaction_params[:account_id])
    send_notification(user) if account.notification == true && (transaction_params[:amount] < account.critical_value.to_s)
  end

  def send_notification(user)
    # for production use some smtp config
    UserMailer.notification_email(user).deliver_later # for localhost
  end

  def update_balance(account_id, amount)
    account = Account.find(account_id)
    actual_balance = account.balance
    account.update(balance: actual_balance + amount)
  end
end



