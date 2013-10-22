class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def redirect_to_https
    redirect_to protocol: "https://" + request.host + relative_uri unless (request.ssl? || request.local?)
  end
end
