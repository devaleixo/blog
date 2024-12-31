class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pundit::Authorization

  allow_browser versions: :modern

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:home]

  after_action :verify_authorized, only: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  private

  def user_not_authorized
    flash[:alert] = "Não Autorizado"
    redirect_to(root_path)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
