class CreateCoffees < ActiveRecord::Migration[6.1]
  def change
    create_table :coffees do |t|
      t.string :blend
      t.string :origin
      t.string :variety
      t.integer :price
      t.boolean :decaf
    end
  end
end
