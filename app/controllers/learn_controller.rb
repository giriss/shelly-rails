class LearnController < ApplicationController
  
  require 'net/http'
  skip_before_action :verify_authenticity_token, only: [:lesson3]
  
  def lesson1
    require 'uri'
    require 'net/http'
    require 'net/https'
    
    data = "USER=akhil05%40mail.com&PASSWORD=g1VPD20qBH3qHmzJ&AMOUNT=25&CURRENCY=USD&RECEIVEREMAIL=recipient%40example.com&SENDEREMAIL=myemail%40example.com&PURCHASETYPE=1&NOTE=This+is+a+test+transaction.&TESTMODE=1"
    uri = URI.parse("https://api.payza.com/svc/api.svc/sendmoney")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = https.post(uri.path, data)
    render text: req.message
  end

  def lesson2
    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    uri = URI "http://akh-rails.herokuapp.com/learn/lesson3"
    res = Net::HTTP.post_form uri, :name => @name
    render text: "Hi " + res.body
  end

  def lesson3
    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    render text: "Hello " + @name
  end
end
