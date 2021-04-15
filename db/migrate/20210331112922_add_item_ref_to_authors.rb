class AddItemRefToAuthors < ActiveRecord::Migration[6.1]
  def change
    add_reference :authors, :item, null: false, foreign_key: true
  end
end
