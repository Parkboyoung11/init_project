class ApplicationController < ActionController::Base
  before_action :set_locale

  def default_url_options
    {locale: i18n.locale}
  end

  private

  def set_locale
    i18n.locale = params[:locale] || i18n.default_locale
  end
end
