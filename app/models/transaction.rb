class Transaction < ApplicationRecord
  belongs_to :account

  scope :increments, -> { where("cents_amount >= 0") }
  scope :decrements, -> { where("cents_amount < 0") }

  def dollar_amount
    "%.2f" % (cents_amount / 100.0)
  end
end

