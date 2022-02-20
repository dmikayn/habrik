class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :contents
      t.belongs_to :user
      t.belongs_to :comment
      t.timestamps
    end
  end
end
