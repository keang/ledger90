class AccountsController < ApplicationController
  before_action :authenticate_user!
  helper_method :current_account

  def index
  end

  def show
    @transactions = current_account.transactions.all.order(created_at: :desc)
  end

  def current_account
    @current_account ||= Account.find params[:id]
  end
end
