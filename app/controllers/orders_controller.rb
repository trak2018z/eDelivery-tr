class OrdersController < ApplicationController
  def index
    @orders = Order.where(id: current_user.id)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(allowed_params)
    @order.user = User.find(current_user.id) unless allowed_params[:user_id]

    params[:order]['packages'].each do |key, value|
      value.permit!
      @order.packages.new(value)

    end

    if @order.save
      flash[:success] = "Order has been created."
      redirect_to profile_path
    else
      flash.now[:errors] = @order.errors.full_messages
      render new_order_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def allowed_params
    params.require(:order).permit(:receipt_date, :delivery_date, :user_id, :packages[1..20])
  end
end
