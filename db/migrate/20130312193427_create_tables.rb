class CreateTables < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.column :name, :string

      t.timestamps
    end

    create_table :expenses do |t|
      t.column :name, :string
      t.column :amount, :money
      t.column :expense_date, :date
      t.column :category_id, :integer

      t.timestamps
    end
  end
end
