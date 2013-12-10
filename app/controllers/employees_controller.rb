class EmployeesController < ApplicationController
  def index
    # make your employee objects available to the correlating view here
    @employees = Employee.parse_employees('db/employees.csv')
  end
end
