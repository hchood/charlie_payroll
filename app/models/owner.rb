require_relative 'employee'

class Owner < Employee
  attr_reader :company

  def initialize(first_name, last_name, title, base_salary, company)
    super(first_name, last_name, title, base_salary)
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
