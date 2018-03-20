class ChangeUserToHaveTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :doctor, :boolean, default: false
    add_column :users, :patient, :boolean, default: true
  end
end
