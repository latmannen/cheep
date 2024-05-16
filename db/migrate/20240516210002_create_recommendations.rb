class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.string :visit_type
      t.string :interests
      t.string :other_content

      t.timestamps
    end
  end
end
