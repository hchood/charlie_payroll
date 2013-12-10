class Employee
  attr_reader :name, :last_name, :base_salary

  @@employees = []

  TAX_RATE = 0.30

  def initialize(name, base_salary)
    @name = name
    @last_name = name.split(/ /).last
    @base_salary = base_salary.to_f
  end

  def self.employees
    @@employees
  end

  def self.parse_employees(filename)
    CSV.foreach(filename, headers: true) do |row|
      if row["type"] == "1"
        @@employees << Employee.new(row["name"], row["base_salary"])
      elsif row["type"] == "2"
        @@employees << CommissionSalesPerson.new(row["name"], row["base_salary"], row["commission"])
      elsif row["type"] == "3"
        @@employees << QuotaSalesPerson.new(row["name"], row["base_salary"], row["quota_bonus"], row["quota"])
      elsif row["type"] == "4"
        @@employees << Owner.new(row["name"], row["base_salary"], Company.new(row["company_quota"]))
      else
        puts "Error"
      end
    end
  end

  def gross_monthly_salary
    @base_salary / 12
  end

  def net_pay
    self.gross_monthly_salary * (1 - TAX_RATE)
  end
end

class CommissionSalesPerson < Employee
  attr_reader :sales, :commission

  def initialize(name, base_salary, commission_percentage)
    super(name, base_salary)
    @commission = commission_percentage.to_f
    @sales = 0
  end

  def add_sale(amount)
    @sales += amount
  end

  def commission
    @sales * @commission
  end

  def net_pay
    super + self.commission * (1 - TAX_RATE)
  end
end

class QuotaSalesPerson < Employee
  attr_reader :sales

  def initialize(name, base_salary, quota_bonus, quota)
    super(name, base_salary)
    @quota_bonus = quota_bonus.to_i
    @quota = quota.to_i
    @sales = 0
  end

  def hit_quota?
    @sales >= @quota
  end

  def add_sale(amount)
    @sales += amount
  end

  def bonus
    if self.hit_quota?
      @quota_bonus
    else
      0
    end
  end

  def net_pay
    super + self.bonus * (1 - TAX_RATE)
  end
end

class Owner < Employee
  attr_reader :company

  def initialize(name, base_salary, company)
    super(name, base_salary)
    @company = company
  end

  def bonus
    if @company.hit_quota?
      1000
    else
      0
    end
  end

  def net_pay
    super + self.bonus * (1 - TAX_RATE)
  end
end
