class Employee < ApplicationRecord
    has_many :free_times
    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    
    def total_vacation_days
        free_times.where(leave_type: :Vacaciones, state: :Aprobado).sum(&:vacation_days)
    end
end
