class RenameUserToAuthorInComments < ActiveRecord::Migration[8.0]
  def change
    # Renomear a coluna user_id para author_id
    rename_column :comments, :user_id, :author_id

    # Atualizar a chave estrangeira
    remove_foreign_key :comments, :users
    add_foreign_key :comments, :users, column: :author_id

    # Permitir valores nulos
    change_column_null :comments, :author_id, true
  end
end
