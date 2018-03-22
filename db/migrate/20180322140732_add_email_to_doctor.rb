class AddEmailToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :email, :string
  end
end
