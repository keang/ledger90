class TransactionsController < ApplicationController
  before_action :authenticate_user!
  helper_method :current_account

  def new
    @transaction = Transaction.new(account: current_account)
  end

  def current_account
    @current_account ||= Account.find params[:account_id]
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      flash[:success] = "Transaction successfully recorded"
      redirect_to account_path(@transaction.account)
    else
      render 'new'
    end
  end

  def edit
    @transaction = current_account.transactions.find params[:id]
  end

  def update
    @transaction = current_account.transactions.find params[:id]
    if @transaction.update(transaction_params)
      flash[:success] = "Transaction successfully updated"
      redirect_to account_path(@transaction.account)
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = current_account.transactions.find params[:id]
    @transaction.destroy
    flash[:warning] = "Transaction successfully destroyed"
    redirect_to account_path(@transaction.account)
  end

  private
  def transaction_params
    params.require(:transaction).permit(:description, :cents_amount, :account_id, :payment_mode)
  end
end
