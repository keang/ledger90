class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.all.order(created_at: :desc)
  end

  def new
    @transaction = Transaction.new(user: current_user)
  end
end
