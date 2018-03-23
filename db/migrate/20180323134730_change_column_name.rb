class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :patients, :doctors_id, :doctor_id
  end
end
