class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unuique: true
  end
end
