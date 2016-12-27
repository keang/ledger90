class AddFieldsToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :cents_amount, :integer
    add_column :transactions, :description, :string
  end
end
