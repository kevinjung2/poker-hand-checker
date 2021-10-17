class CreateHands < ActiveRecord::Migration[6.1]
  def change
    create_table :hands do |t|
      t.string :score
      t.timestamps
    end
  end
end
