class Transaction < ApplicationRecord
  belongs_to :account

  def dollar_amount
    "%.2f" % (cents_amount / 100)
  end
end

