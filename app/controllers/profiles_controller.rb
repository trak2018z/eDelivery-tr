class ProfilesController < ApplicationController
  before_action :set_prefix

  def show
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def update
    @profile = Profile.find(params[:id])
    @user = User.find(current_user.id)
    errors = nil
    errors = [:user_email, @user.errors[:email][0]] unless @user.update(email: allowed_params[:user][:email])
    current_user.email = @user.email
    attributes = allowed_params.to_h || {}
    attributes.delete :user

    remote_create_or_update(@profile, attributes, 'profile',
                            'update', nil, errors)
  end

  private
  def allowed_params
    params.require(:profile).permit(:name, :surname, :full_name, :phone, user:[:email])
  end

  def set_prefix
    @prefix = 'profile_'
  end
end
