class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show update destroy ]

  # GET /employees
  def index
    
    @employees = Employee.all
    # Filtrar por id
    @employees = @employees.where(id: params[:id]) if params[:id].present?

    # Filtrar por name
    @employees = @employees.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?

    # Filtrar por email
    @employees = @employees.where('email LIKE ?', "%#{params[:email]}%") if params[:email].present?

    @employees = @employees.page(params[:page]).per(params[:per_page] || 10)

    render json: {
      employees: @employees,
      meta: {
        total_pages: @employees.total_pages,
        current_page: @employees.current_page,
        next_page: @employees.next_page,
        prev_page: @employees.prev_page,
        total_count: @employees.total_count
      }
    }
  end

  # GET /employees/1
  def show
    render json: @employee
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:name, :email)
    end
end
