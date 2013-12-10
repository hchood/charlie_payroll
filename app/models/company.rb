class Company
  attr_reader :monthly_quota, :sales

  def initialize(monthly_quota)
    @monthly_quota = monthly_quota.to_i
    @sales = 0
  end

  def import_sales
    @sales = Sale.gross_sales
  end

  def hit_quota?
    @sales >= @monthly_quota
  end
end
