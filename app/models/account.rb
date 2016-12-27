class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  TYPE = %w(Asset Expense Income Equity Liability)

  def dollar_balance
    "%.2f" % (cents_balance / 100.0)
  end
end

class Asset < Account; end

class Expense < Account; end

class Income < Account; end

class Equity < Account; end

class Liability < Account; end
