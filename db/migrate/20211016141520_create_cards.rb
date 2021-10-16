class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :suit
      t.string :name
      t.integer :value
      t.timestamps
    end
  end
end
