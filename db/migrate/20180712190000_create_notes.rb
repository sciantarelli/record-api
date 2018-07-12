class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :name
      t.text :content

      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
