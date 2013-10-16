class LearnController < ApplicationController

  require 'uri'
  require 'net/http'
  require 'net/https'
  skip_before_action :verify_authenticity_token, only: [:lesson3]
  
  def lesson1
    # POST a send money using Payza api (Testmode=TRUE)
    @data = {
      :USER => "akhil05@mail.com",
      :PASSWORD => "vaHYkV4Mkwqv8dzF",
      :AMOUNT => "25",
      :CURRENCY => "USD",
      :RECEIVEREMAIL => "client_1_akhil05@mail.com",
      :SENDEREMAIL => "akhil05@mail.com",
      :PURCHASETYPE => "1",
      :NOTE => "This is a test transaction.",
      :TESTMODE => "1"
    }
    @url = "https://api.payza.com/svc/api.svc/sendmoney"
    @uri = URI @url
#=begin
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
#=end
#   @req = Net::HTTP.post_form @uri, @data
    @ret = "Post to send money using payza (Test mode), pretty c0ol huh !?!<br />" + @req.body
    render text: @ret
  end

  def lesson2
    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    @uri = URI "http://gagkas.tk/learn/lesson3"
    @res = Net::HTTP.post_form @uri, :name => @name
    render text: "Hi " + @res.body
  end

  def lesson3
    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    render text: "Hello " + @name + " !?!"
  end
  
  def lesson4
    # payments made using paypal sandbox
    @data = {
      :METHOD => "MassPay",
      :VERSION => "90",
      :EMAILSUBJECT => "C0ol !! Aint' it, you have just received your payments from sum.mn ! :*",
      :USER => "akhil05_api1.mail.com",
      :PWD => "1381743824",
      :SIGNATURE => "AP8wAEeWcdquPOE6hUJmW1U9KBctAiUTu.2IbHJTknQnojFEGJvXtVHr",
      :RECEIVERTYPE => "EmailAddress",
      :CURRENCYCODE => "USD",
      :L_EMAIL0 => "akhile@dr.com",
      :L_AMT0 => "10",
      :L_NOTE0 => "Keep up the good work. Eny0yZz !! ;)"
    }
    @url = "https://api-3t.sandbox.paypal.com/nvp"
    @uri = URI @url
#=begin
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
#=end
#   @req = Net::HTTP.post_form @uri, @data
    @ret = "Post to send money using PayPal! yeah I did it ;) !! ^_^<br />" + @req.body
    render text: @ret
  end
  
  def lesson5
    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    @uri = URI "http://akhdjan.tk/learn/lesson2/"
    @res = Net::HTTP.post_form @uri, :name => @name
    render text: "Hi " + @res.body
  end
  
  def lesson6
    
  end
  
  def lesson7
    @data = {
      :METHOD => "setExpressCheckout",
      :VERSION => "90",
      :USER => "akhil05_api1.mail.com",
      :PWD => "1381743824",
      :SIGNATURE => "AP8wAEeWcdquPOE6hUJmW1U9KBctAiUTu.2IbHJTknQnojFEGJvXtVHr",
      :PAYMENTREQUEST_0_AMT => "10",
      :PAYMENTREQUEST_0_CURRENCYCODE => "USD",
      :PAYMENTREQUEST_0_PAYMENTACTION => "SALE",
      :returnUrl => "http://gagkas.tk/learn/lesson10",
      :cancelUrl => "http://fb.com"
    }
    @url = "https://api-3t.sandbox.paypal.com/nvp"
    @uri = URI @url
#=begin
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
#=end
#   @req = Net::HTTP.post_form @uri, @data
    @token = @req.body.split('=')[1].split('&')[0]
    redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{@token}"
  end
  
  def lesson8
    @token = params[:token]
    @data = {
      :METHOD => "GetExpressCheckoutDetails",
      :VERSION => "90",
      :USER => "akhil05_api1.mail.com",
      :PWD => "1381743824",
      :SIGNATURE => "AP8wAEeWcdquPOE6hUJmW1U9KBctAiUTu.2IbHJTknQnojFEGJvXtVHr",
      :TOKEN => @token
    }
    @url = "https://api-3t.sandbox.paypal.com/nvp"
    @uri = URI @url
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
    @payerid = params[:PayerID] #@req.body.split("PAYERID=")[1].split("&")[0]
    @data = {
      :METHOD => "DoExpressCheckoutPayment",
      :VERSION => "90",
      :USER => "akhil05_api1.mail.com",
      :PWD => "1381743824",
      :SIGNATURE => "AP8wAEeWcdquPOE6hUJmW1U9KBctAiUTu.2IbHJTknQnojFEGJvXtVHr",
      :TOKEN => @token,
      :PAYERID => @payerid,
      :PAYMENTREQUEST_0_AMT => "10",
      :PAYMENTREQUEST_0_CURRENCYCODE => "USD",
      :PAYMENTREQUEST_0_PAYMENTACTION => "SALE"
    }
    @url = "https://api-3t.sandbox.paypal.com/nvp"
    @uri = URI @url
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
    render text: @req.body + "<br />Payments done i guess :p"
  end
  
end
