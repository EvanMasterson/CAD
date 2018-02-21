class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.date :dob
      t.string :address
      t.integer :phone
      t.string :symptom

      t.timestamps
    end
  end
end
