# +Account+ is subclassed by account types Asset, Expense, Income, Equity and Liability
#
# Asset and Expense take negative transactions as credits, while other types take them as debits,
# and vice versa.
# See http://accounting-simplified.com/financial/double-entry/debit-&-credit.html
#
class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  TYPE = %w(Asset Expense Income Equity Liability)

  def dollar_balance
    "%.2f" % (cents_balance / 100.0)
  end

  def debits
    if debit_positive?
      self.transactions.increments
    else
      self.transactions.decrements
    end
  end

  def credits
    if debit_positive?
      self.transactions.decrements
    else
      self.transactions.increments
    end
  end
end

class Asset < Account
  def debit_positive?; true end
end

class Expense < Account
  def debit_positive?; true end
end

class Income < Account
  def debit_positive?; false end
end

class Equity < Account
  def debit_positive?; false end
end

class Liability < Account
  def debit_positive?; false end
end

