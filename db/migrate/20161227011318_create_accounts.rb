class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.integer    :cents_balance
      t.string     :type
      t.string     :name

      t.timestamps
    end

    add_reference :transactions, :account, foreign_key: true
  end
end
