class AddPatientsToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_reference :patients, :doctors, foreign_key: true
  end
end
