class TransactionsController < ApplicationController
  before_action :authenticate_user!
  helper_method :current_account

  def new
    @transaction = Transaction.new(account: current_account)
  end

  def current_account
    @current_account ||= Account.find params[:account_id]
  end
end
