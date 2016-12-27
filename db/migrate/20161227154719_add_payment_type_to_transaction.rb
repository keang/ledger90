class AddPaymentTypeToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :payment_mode, :string
  end
end
