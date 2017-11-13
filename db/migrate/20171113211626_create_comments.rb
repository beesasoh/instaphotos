class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :text
      t.references :commentable, polymorphic: true
      t.timestamps
    end
    add_index :comments, :user_id
  end
end
