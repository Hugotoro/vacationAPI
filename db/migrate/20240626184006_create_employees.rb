class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :leader
      t.date :start_date
      t.date :end_date
      t.string :employee_type
      t.string :reason
      t.boolean :state
      t.string :email

      t.timestamps
    end
  end
end
