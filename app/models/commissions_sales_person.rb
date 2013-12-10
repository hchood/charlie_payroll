require_relative 'employee'

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