class ChangeUserMigration < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :firstName, :string
    add_column :users, :lastName, :string
    add_column :users, :dob, :date
    add_column :users, :address, :string
    add_column :users, :phone, :integer
  end
end
