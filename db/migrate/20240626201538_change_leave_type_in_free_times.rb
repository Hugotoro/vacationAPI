class ChangeLeaveTypeInFreeTimes < ActiveRecord::Migration[7.1]
  def change
    remove_column :free_times, :leave_type, :string
    
    add_column :free_times, :leave_type, :integer
  end
end
