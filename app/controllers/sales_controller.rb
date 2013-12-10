class SalesController < ApplicationController
  def index
    @sales = Sale.parse_sales('db/sales.csv')
  end
end
