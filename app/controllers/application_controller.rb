class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  ## Helpers,
  def remote_create_or_update(record, params, name_of_model, type_of_action, view = nil, errors = nil)
    type_of_action == 'create' ?  @action = record.save : @action = record.update(params)
    respond_to do |format|
      if @action && errors.nil?
        flash.now[:success] = name_of_model.capitalize + ' succesfully '+type_of_action+'d.'
        if view.nil?
          format.js
        else
          format.js { render action: view }
        end
      else
        record.errors.add(errors[0],errors[1]) unless errors.nil?
        format.json do
          render json: { prefix: name_of_model.downcase + '_', errors: record.errors },
                 status: :unprocessable_entity
        end
      end
    end
  end

end
