class AddBirthdateToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :birthdate, :date
  end
end
