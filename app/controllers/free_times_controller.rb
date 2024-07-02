class FreeTimesController < ApplicationController
  before_action :set_free_time, only: %i[ show update destroy ]
  before_action :set_employee, only: %i[ index ]

  # GET /free_times
  def index
    @free_times = if @employee
                    @employee.free_times
                  else
                    FreeTime.all
                  end

    # Aplicar filtros
    @free_times = @free_times.where(id: params[:id]) if params[:id].present?

    if params[:employee_name].present?
      @free_times = @free_times.joins(:employee).where('employees.name LIKE ?', "%#{params[:employee_name]}%")
    end

    if params[:employee_email].present?
      @free_times = @free_times.joins(:employee).where('employees.email LIKE ?', "%#{params[:employee_email]}%")
    end

    @free_times = @free_times.where(leader: params[:leader]) if params[:leader].present?

    if params[:from_date].present? && params[:to_date].present?
      from_date = Date.parse(params[:from_date])
      to_date = Date.parse(params[:to_date])
      @free_times = @free_times.where('start_date >= ? AND end_date <= ?', from_date, to_date)
    end

    @free_times = @free_times.where(leave_type: params[:leave_type]) if params[:leave_type].present?
    @free_times = @free_times.where(state: params[:state]) if params[:state].present?

    # Paginación
    @free_times = @free_times.page(params[:page]).per(params[:per_page] || 10)

    render json: {
      free_times: @free_times,
      meta: {
        total_pages: @free_times.total_pages,
        current_page: @free_times.current_page,
        next_page: @free_times.next_page,
        prev_page: @free_times.prev_page,
        total_count: @free_times.total_count
      }
    }
  end

  # GET /free_times/1
  def show
    render json: @free_time
  end

  # POST /free_times
  def create
    @free_time = FreeTime.new(free_time_params)

    if @free_time.save
      render json: @free_time, status: :created, location: @free_time
    else
      render json: @free_time.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /free_times/1
  def update
    if @free_time.update(free_time_params)
      render json: @free_time
    else
      render json: @free_time.errors, status: :unprocessable_entity
    end
  end

  # DELETE /free_times/1
  def destroy
    @free_time.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_free_time
      @free_time = FreeTime.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'FreeTime not found' }, status: :not_found
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end

    def set_employee
      @employee = Employee.find(params[:employee_id]) if params[:employee_id]
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Employee not found' }, status: :not_found
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end

    # Only allow a list of trusted parameters through.
    def free_time_params
      params.require(:free_time).permit(:employee_id, :leader, :start_date, :end_date, :leave_type, :reason, :state, :vacation_days)
    end
end
