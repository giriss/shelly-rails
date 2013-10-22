class WelcomeController < ApplicationController
  before_filter :redirect_to_https, only: ["home"]
  def home
    @message = "Welcome dr."
  end
  
  def ssl
    @ret = <<-EOF
037663EB86F368ACDF991DDAC6BB4A5253E51147
comodoca.com
EOF
    render text: @ret
  end
end
