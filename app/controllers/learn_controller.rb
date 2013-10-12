class LearnController < ApplicationController

  require 'uri'
  require 'net/http'
  require 'net/https'
  skip_before_action :verify_authenticity_token, only: [:lesson3]
  
  def lesson1
    # POST a send money using Payza api (Testmode=TRUE)
    @data = {
      :USER => "akhil05@mail.com",
      :PASSWORD => "GYKDrxxSRLtYlonp",
      :AMOUNT => "25",
      :CURRENCY => "USD",
      :RECEIVEREMAIL => "client_1_akhil05@mail.com",
      :SENDEREMAIL => "akhil05@mail.com",
      :PURCHASETYPE => "1",
      :NOTE => "This+is+a+test+transaction.",
      :TESTMODE => "1"
    }
    @url = "https://sandbox.Payza.com/api/api.svc/sendmoney"
    @uri = URI.parse(@url)
    @https = Net::HTTP.new(@uri.host,@uri.port)
    @https.use_ssl = true
    @post = Net::HTTP::Post.new(@uri.path)
    @post.set_form_data(@data)
    @req = @https.request(@post)
    @ret = @req.body # "Req.message: " + @req.message + "<br />Req.code: " + @req.code + "<br />Response: " + @req.body
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
