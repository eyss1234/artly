class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :details
      t.integer :rating
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
