class CreateCardboardTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :cardboard_types do |t|
      t.string :card_type
      t.integer :price

      t.timestamps
    end
  end
end
