class OrdersController < ApplicationController
  include ApplicationHelper
  before_action :set_prefix

  def index

  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(allowed_params)
    @order.user = User.find(current_user.id) unless allowed_params[:user_id]
    @order.source_address = Address.find(allowed_params[:source_address_id])
    @order.target_address = Address.find(allowed_params[:target_address_id])
    set_price_for_each_package(params[:order]['packages'])

    if @order.save
      flash[:success] = 'Order has been created.'
      redirect_to packages_path
    else
      flash.now[:errors] = @order.errors.full_messages
      render new_order_path
    end
  end

  def edit
    @order = Order.find(params[:id])
    @order.date_to_picker
    respond_to :js
  end

  def update
    @order = Order.find(params[:id])
    remote_create_or_update(@order, allowed_params, 'order', 'update')
  end

  def destroy
    @order = Order.find_by(id: params[:id])

    @order.destroy  ?
        flash[:notice] = 'Order succesfully removed.' :
        flash[:danger] = 'Something went wrong.'
    respond_to :js
  end

  private
  def allowed_params
    params.require(:order).permit(:receipt_date, :delivery_date, :user_id, :source_address_id, :target_address_id, :packages[1..20])
  end

  def set_price_for_each_package(packages)
    packages.each do |key, value|
      value.permit!
      price = 0
      value.each do |k, v|
        element = price_of_package_element[k.to_sym]
        price += element*Integer(v) unless element.nil?
      end
      value[:price] = sprintf('%.2f',price)
      @order.packages.new(value)
    end
  end

  def set_prefix
    @prefix = 'order_'
  end
end
