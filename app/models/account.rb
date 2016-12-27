class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
end

class Asset < Account; end

class Expense < Account; end

class Income < Account; end

class Equity < Account; end

class Liability < Account; end
