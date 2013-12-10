require_relative 'employee'

class QuotaSalesPerson < Employee
  attr_reader :sales

  def initialize(first_name, last_name, title, base_salary, quota_bonus, quota)
    super(first_name, last_name, title, base_salary)
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
