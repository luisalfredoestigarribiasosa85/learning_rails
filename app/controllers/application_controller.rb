class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def authorize_admin!
    return if current_user&.admin?

    redirect_to products_path, alert: "You don't have permission to perform this action."
  end
end
