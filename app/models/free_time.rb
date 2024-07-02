class FreeTime < ApplicationRecord
  belongs_to :employee
  enum leave_type: { Vacaciones: 0, Incapacidad: 1}
  enum state: { Aprobado: 0, Rechazado: 1, Pendiente: 2}

  def vacation_days
    if leave_type == "Vacaciones" && state == "Aprobado" && start_date.present? && end_date.present?
    (end_date - start_date).to_i + 1
    else
      0
    end
  end
end
