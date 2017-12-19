class AddressesController < ApplicationController
  before_action :set_prefix

  def index
    redirect_to profile_path
  end

  def new
    @address = Address.new
    respond_to :js
  end

  def create
    @address = Address.new(allowed_params)
    @address.user_id = current_user.id unless allowed_params[:user_id]
    remote_create_or_update(@address, allowed_params, 'address', 'create')
  end

  def edit
    @address = Address.find(params[:id])
    respond_to :js
  end

  def update
    @address = Address.find(params[:id])
    remote_create_or_update(@address, allowed_params, 'address', 'update', 'create')
  end

  def destroy
    @address = Address.find_by(id: params[:id])
    orders = Order.where(source_address_id: @address.id).or(Order.where(target_address_id: @address.id))

    query_effect =  orders.empty? ? @address.destroy : @address.update(user_id: nil)

    query_effect ?
        flash.now[:notice] = 'Address succesfully deleted.' :
        flash.now[:danger] = 'Something went wrong.'
    respond_to :js
  end

  private
  def allowed_params
    params.require(:address).permit(:country, :postal_code, :city, :street,
                                    :building_number, :apartment_number, :user_id)
  end

  def set_prefix
    @prefix = 'address_'
  end

end
