class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :content
      t.string :imageable_type
      t.integer :imageable_id

      t.timestamps
    end
    add_index :images, [:imageable_type, :imageable_id]
  end
end
