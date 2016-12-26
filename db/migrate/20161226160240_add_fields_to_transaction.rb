class AddFieldsToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :type, :string
    add_column :transactions, :cents_amount, :integer
    add_column :transactions, :target, :string
    add_column :transactions, :source, :string
    add_column :transactions, :description, :string
    add_reference :transactions, :user, foreign_key: true
  end
end
