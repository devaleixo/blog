class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :author, null: false, foreign_key: true
      t.boolean :anonymous
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
