class CreateClinics < ActiveRecord::Migration[5.1]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :location
      t.string :specialisations
      t.string :description

      t.timestamps
    end
  end
end
