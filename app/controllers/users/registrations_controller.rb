class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_prefix
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]


  def new
    super
  end

  def create
    super do
      resource.profile = Profile.new(email: sign_up_params[:email])
      resource.save
    end
  end


  def edit
    super
  end


  def update
    @user = User.find(current_user.id)
    valid_password = @user.valid_password?(allowed_params[:current_password])
    if valid_password && @user.update(allowed_params)
      bypass_sign_in(@user)
      flash[:success] = 'Password successfully changed.'
    else
        @user.errors.add(:current_password, "Password doesn't match") unless valid_password
        render json: {prefix: @prefix,errors: @user.errors},
               status: :unprocessable_entity
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  #
  def profile; end

  def index; end

  protected

  def allowed_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def set_prefix
    @prefix = 'user_'
  end
  #def configure_sign_up_params
 # end

 # def configure_account_update_params
  #end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
