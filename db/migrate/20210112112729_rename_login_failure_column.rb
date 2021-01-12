class RenameLoginFailureColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :loging_failure_count, :login_failure_count
  end
end
