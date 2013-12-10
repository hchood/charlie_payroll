class Employee
  attr_reader :first_name, :last_name, :title, :base_salary

  TAX_RATE = 0.30

  def initialize(first_name, last_name, title, base_salary)
    @first_name = first_name
    @last_name = last_name
    @title = title
    @base_salary = base_salary.to_f
  end

  def self.employees
    @@employees
  end

  def self.parse_employees(filename)
    @@employees = []
    CSV.foreach(filename, headers: true) do |row|
      if row["type"] == "1"
        @@employees << Employee.new(row["first_name"], row["last_name"], row["title"], row["base_salary"])
      elsif row["type"] == "2"
        @@employees << CommissionSalesPerson.new(row["first_name"], row["last_name"], row["title"], row["base_salary"], row["commission"])
      elsif row["type"] == "3"
        @@employees << QuotaSalesPerson.new(row["first_name"], row["last_name"], row["title"], row["base_salary"], row["quota_bonus"], row["quota"])
      elsif row["type"] == "4"
        @@employees << Owner.new(row["first_name"], row["last_name"], row["title"], row["base_salary"], Company.new(row["company_quota"]))
      else
        puts "Error"
      end
    end
    @@employees
  end

  def gross_monthly_salary
    @base_salary / 12
  end

  def net_pay
    self.gross_monthly_salary * (1 - TAX_RATE)
  end
end
