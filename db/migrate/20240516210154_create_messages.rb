class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.string :role
      t.integer :rec_id

      t.timestamps
    end
  end
end
