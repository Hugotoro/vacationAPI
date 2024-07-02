class RemoveUnwantedFieldsFromEmployee < ActiveRecord::Migration[7.1]
  def change
    remove_column :employees, :leader
    remove_column :employees, :start_date
    remove_column :employees, :end_date
    remove_column :employees, :employee_type
    remove_column :employees, :reason
    remove_column :employees, :state
  end
end
