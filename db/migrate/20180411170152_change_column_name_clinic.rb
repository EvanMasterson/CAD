class ChangeColumnNameClinic < ActiveRecord::Migration[5.1]
  def change
    rename_column :clinics, :specialisations, :specialisation
  end
end
