class LearnController < ApplicationController

  require 'uri'
  require 'net/http'
  require 'net/https'
  skip_before_action :verify_authenticity_token, only: [:lesson3]
  
  def lesson1
    # POST a send money using Payza api (Testmode=TRUE)
    @data = "USER=seller_1_akhil05%40mail.com&PASSWORD=Zcf2bNJSg24bZoTY&AMOUNT=25&CURRENCY=USD&RECEIVEREMAIL=client_1_akhil05%40mail.com&SENDEREMAIL=seller_1_akhil05%40mail.com&PURCHASETYPE=1&NOTE=This+is+not+a+test+transaction.&TESTMODE=1"
    @uri = URI.parse("https://api.payza.com/svc/api.svc/sendmoney")
    @https = Net::HTTP.new(@uri.host,@uri.port)
    @https.use_ssl = true
    @req = @https.post(@uri.path, @data)
    @ret = "Req.message: " + @req.message + "<br />Req.code: " + @req.code + "<br />Response: " + @req.body
    render text: @ret
  end

  def lesson2
    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    @uri = URI "http://akh-rails.herokuapp.com/learn/lesson3"
    @res = Net::HTTP.post_form @uri, :name => @name
    render text: "Hi " + @res.body
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
