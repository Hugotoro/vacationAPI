class ChangeStateInFreeTimes < ActiveRecord::Migration[7.1]
  def change
    remove_column :free_times, :state, :boolean
    
    add_column :free_times, :state, :integer
  end
end
