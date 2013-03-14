class CreateJoinTable < ActiveRecord::Migration
  def change
    create_table :ties do |t|
      t.column :expense_id, :integer
      t.column :category_id, :integer

      t.timestamps
    end
  end
end
