class CreateCardHands < ActiveRecord::Migration[6.1]
  def change
    create_table :card_hands do |t|
      t.integer :hand_id
      t.integer :card_id
      t.timestamps
    end
  end
end
