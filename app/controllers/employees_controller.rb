class EmployeesController < ApplicationController
  before_action :fetch_employee, only: %i[show update destroy edit]

  def index
    @employees = Employee.all.order(id: :asc)
  end

  def show; end

  def new
    @employee = Employee.new
    @address = Address.new
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.hobbies_data = params['employee']['hobbies']
    if @employee.save
      redirect_to employees_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @address = Address.find_by(employee_id: @employee.id)
  end

  def update
    @employee.hobbies_data = params['employee']['hobbies']
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
    @employees = Employee.where('employee_name LIKE ?', '%' + params[:search_employee] + '%')
    render :index
  end

  private

  def fetch_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:employee_name, :email, :password, :gender, :address, :mobile_number,
                                     :birth_date, :document, hobbies: [''],
                                                             addresses_attributes: %i[house_name street_name road])
  end
end
