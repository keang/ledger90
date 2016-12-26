class Transaction < ApplicationRecord
  belongs_to :user

  def dollar_amount
    "%.2f" % (cents_amount / 100)
  end
end

