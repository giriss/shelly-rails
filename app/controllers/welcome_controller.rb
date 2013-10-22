class WelcomeController < ApplicationController
  before_filter :redirect_to_https, only: ["home"]
  def home
    @message = "Welcome dr."
  end
  
  def index
    @ret = "Welcome without SSL"
    render text: @ret
  end
end
