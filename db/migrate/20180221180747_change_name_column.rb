class ChangeNameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :patients, :name, :firstName
    add_column :patients, :lastName, :string
  end
end
