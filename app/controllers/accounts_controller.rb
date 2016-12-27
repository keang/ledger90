class AccountsController < ApplicationController
  before_action :authenticate_user!
  helper_method :current_account

  def index
  end

  def show
    @transactions = current_account.transactions.all.order(created_at: :desc)
  end

  def new
    @account = current_user.accounts.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:success] = "Account successfully created"
      redirect_to account_path(@account)
    else
      render 'new'
    end
  end

  def current_account
    @current_account ||= current_user.accounts.find params[:id]
  end

  private
  def account_params
    params.require(:account).permit(:name, :type, :user_id, :cents_balance)
  end
end
