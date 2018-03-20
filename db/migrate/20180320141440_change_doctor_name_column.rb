class ChangeDoctorNameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :doctors, :name, :firstName
    add_column :doctors, :lastName, :string
  end
end
