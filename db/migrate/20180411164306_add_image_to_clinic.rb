class AddImageToClinic < ActiveRecord::Migration[5.1]
  def change
    add_column :clinics, :image, :string
  end
end
