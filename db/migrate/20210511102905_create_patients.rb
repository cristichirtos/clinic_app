class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :id_card_number
      t.integer :personal_numerical_code
      t.date :date_of_birth
      t.string :address

      t.timestamps
    end
  end
end
