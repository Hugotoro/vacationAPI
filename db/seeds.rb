# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

CSV.foreach(Rails.root.join('db', 'csv', 'free_time.csv'), headers: true) do |row|
  # Procesamiento de cada fila del CSV para crear registros en la base de datos
  Employee.find_or_create_by!(
    id: row['ID'],
    name: row['Nombre'],
    email: row['Email']
  )

  FreeTime.find_or_create_by!(
    employee_id: Employee.find_by(email: row['Email']).id,
    leader: row['Lider'],
    start_date: Date.strptime(row['Fecha desde'], '%d/%m/%Y').strftime('%Y-%m-%d'),
    end_date: Date.strptime(row['Fecha hasta'], '%d/%m/%Y').strftime('%Y-%m-%d'),
    leave_type: row['Tipo'],
    reason: row['Motivo'],
    state: row['Estado']
  )
end
    