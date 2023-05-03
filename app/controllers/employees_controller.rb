class EmployeesController < ApplicationController
  before_action :fetch_employee, only: %i[show update destroy edit]

  def index
    @employees = Employee.all.order(id: :asc)
  end

  def show; end

  def new
    @employee = Employee.new
    @employee.addresses.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @employee.update(employee_params)
      redirect_to employee_path(@employee)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy

    redirect_to employees_path
  end

  def search
    @employees = Employee.where('employee_name LIKE ?', "%#{params[:search_employee]}%")
    render :index
  end

  private

  def fetch_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:employee_name, :email, :password, :gender, :address, :mobile_number,
                                     :birth_date, :document, hobby_ids: [],
                                                             addresses_attributes: %i[id house_name street_name road])
  end
end
