class AddDefaultFalseToAnonymousInComments < ActiveRecord::Migration[8.0]
  def change
    change_column_default :comments, :anonymous, false
  end
end
