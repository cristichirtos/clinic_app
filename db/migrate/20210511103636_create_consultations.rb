class CreateConsultations < ActiveRecord::Migration[6.1]
  def change
    create_table :consultations do |t|
      t.references :doctor, references: :user, null: false, foreign_key: { to_table: :users }
      t.references :patient, null: false, foreign_key: true
      t.datetime :date_time

      t.timestamps
    end
  end
end
