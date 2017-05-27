class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :key
      t.string :description
      t.references :developer
    end
  end
end
