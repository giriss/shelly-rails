class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def need_ssl
    redirect_to protocol: "https://" unless (request.ssl? || RAILS_ENV != "production")
  end
end
