class AddressesController < ApplicationController
  def index
    redirect_to profile_path
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(allowed_params)
    @address.user_id = current_user.id unless allowed_params[:user_id]
    if @address.save
      flash[:notice] = 'Successfully added address.'
      redirect_to profile_path
    else
      flash[:errors] = @address.errors.full_messages
      render :new
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(allowed_params)
      flash[:success] = "Address updated."
      redirect_to profile_path
    else
      flash.now[:errors] = @address.errors
      render edit
    end

  end

  def destroy
    Address.find_by(id: params[:id]).destroy
    flash[:notice] = 'Address has been deleted.'
    redirect_to profile_path
  end

  def allowed_params
    params.require(:address).permit(:country, :region, :city, :street,
                                    :building_number, :apartment_number, :user_id)
  end
end
