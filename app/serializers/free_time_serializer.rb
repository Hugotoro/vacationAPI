class FreeTimeSerializer < ActiveModel::Serializer
  attributes :employee_id, :leader, :start_date, :end_date, :leave_type, :reason, :state, :vacation_days
  attribute :employee_name, if: -> { object.employee }
  attribute :employee_email, if: -> { object.employee }

  def employee_name
    object.employee.name if object.employee
  end

  def employee_email
    object.employee.email if object.employee
  end
end
