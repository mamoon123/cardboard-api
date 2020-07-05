class Api::V1::OrdersController < ApplicationController

  def index
    @orders = @current_user.orders.all
    respond_to do |format|
      if @orders
        format.json { render json: { message: 'Orders List', orders: @orders, status: 200 }}
      else
        format.json { render json: { message: 'Orders not found', orders: []}, status: 401}
      end
    end
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save!
        format.json { render json: { message: 'Order Created', order: @order, status: 200 }}
      else
        format.json { render json: { message: 'Orders not created', orders: []}, status: 401}
      end
    end
  end

  private

  def order_params
    params.permit(:quantity, :price, :user_id, :shipping_fee, :discount, :total_price, :card_type)
  end

end
