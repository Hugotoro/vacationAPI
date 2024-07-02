class EmployeeSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :total_vacation_days
end
  