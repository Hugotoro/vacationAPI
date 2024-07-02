class CreateFreeTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :free_times do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :leader
      t.date :start_date
      t.date :end_date
      t.string :leave_type
      t.string :reason
      t.boolean :state

      t.timestamps
    end
  end
end
