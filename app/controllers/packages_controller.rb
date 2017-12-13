class PackagesController < ApplicationController
  include ApplicationHelper
  def index; end

  def new
    @package = Package.new
    @order_id = params[:order]
    respond_to :js
  end

  def create
    @package = Package.new(allowed_params)
    price = 0
    allowed_params.each do |k, v|
      element = price_of_package_element[k.to_sym]
      price += element*Integer(v) unless element.nil?
    end
    @package.price = price
    remote_create_or_update(@package, allowed_params, 'package', 'create')
  end

  def edit; end

  def update; end

  def destroy
    @package = Package.find_by(id: params[:id])

    @package.destroy  ?
        flash.now[:notice] = 'Package succesfully removed from order.' :
        flash.now[:danger] = 'Something went wrong.'
    respond_to :js
  end

  private
  def allowed_params
    params.require(:package).permit(:weight, :height, :width, :length, :price, :order_id)
  end

end
