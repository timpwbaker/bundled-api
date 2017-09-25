class CreateBundles < ActiveRecord::Migration[5.1]
  def change
    create_table :bundles do |t|
      t.string :product
      t.uuid :customer_reference
      t.integer :starting_credits
      t.integer :remaining_credits
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
