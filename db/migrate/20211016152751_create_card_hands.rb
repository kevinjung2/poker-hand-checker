class CreateCardHands < ActiveRecord::Migration[6.1]
  def change
    create_table :card_hands do |t|

      t.timestamps
    end
  end
end
