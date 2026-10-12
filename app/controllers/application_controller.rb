class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Clerk::Authenticatable
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  helper_method :current_user_id, :user_signed_in?

  private

  def current_user_id
    clerk&.user_id
  end

  def user_signed_in?
    clerk&.user? || false
  end

  def authenticate_user!
    return if user_signed_in?

    redirect_to login_path, alert: "You must be signed in to continue."
  end

end
