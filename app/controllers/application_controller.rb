class ApplicationController < ActionController::Base
  include Authentication
  helper_method :current_user

  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_user
    return unless cookies.signed[:session_id]
    # Procura pela sessão criada e retorna o usuário associado
    current_session = Session.find_by(id: cookies.signed[:session_id])
    @current_user ||= current_session&.user
  end
end
