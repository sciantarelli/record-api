class AddUserToNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :notes, :user, index: true, foreign_key: true
  end
end
