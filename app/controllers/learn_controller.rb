class LearnController < ApplicationController

  require 'net/http'
  require 'net/https'
  skip_before_action :verify_authenticity_token, only: [:lesson3]
  before_filter :redirect_to_https, only: ["lesson4", "lesson6", "lesson7", "lesson8"]
  
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
    @api = PayPal::SDK::Merchant::API.new
    @mass_pay = @api.build_mass_pay({
      :EmailSubject => "Payment done.. EnjoyZz !!",
      :ReceiverType => "EmailAddress",
      :MassPayItem => [{
        :Note => "Keep the good djob  upZxz!!",
        :ReceiverEmail => "akhile@dr.com",
        :Amount => {
          :currencyID => "USD",
          :value => "10.00" }
          }]
        })
    
    # Make API call & get response
    @mass_pay_response = @api.mass_pay(@mass_pay)
    
    # Access Response
    if @mass_pay_response.success?
      @ret = @mass_pay_response.Ack
    else
      @ret = @mass_pay_response.Errors
    end
    @ret = "Post to send money using PayPal! yeah I did it ;) !! ^_^<br />" + @ret
    
    render text: @ret
  end
  
  def lesson5
    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    @uri = URI "http://hselihka.tk/learn/lesson2/"
    @res = Net::HTTP.post_form @uri, :name => @name
    render text: "Hi " + @res.body
  end
  
  def lesson6
    
  end
  
  def lesson7
    @api = PayPal::SDK::Merchant::API.new
    
    # Build request object
    @set_express_checkout = @api.build_set_express_checkout({
      :SetExpressCheckoutRequestDetails => {
        :ReturnURL => "https://hselihka.tk/learn/lesson8",
        :CancelURL => "https://hselihka.tk/learn/lesson6",
        :PaymentDetails => [{
          :OrderTotal => {
            :currencyID => "USD",
            :value => "12.0" },
          :ItemTotal => {
            :currencyID => "USD",
            :value => "12" },
          :PaymentDetailsItem => [{
            :Name => "Deposit money to hselihka.tk",
            :Quantity => 1,
            :Amount => {
              :currencyID => "USD",
              :value => "12" },
            :ItemCategory => "Digital" }] }] } })
    
    # Make API call & get response
    @set_express_checkout_response = @api.set_express_checkout(@set_express_checkout)
    
    # Access Response
    if @set_express_checkout_response.success?
      @token = @set_express_checkout_response.Token
    else
      @errors = @set_express_checkout_response.Errors
    end

    redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{@token}"
  end
  
  def lesson8
    @api = PayPal::SDK::Merchant::API.new
    
    # Build request object
    @token = params[:token]
    @get_express_checkout_details = @api.build_get_express_checkout_details({
      :Token => @token })
    
    # Make API call & get response
    @get_express_checkout_details_response = @api.get_express_checkout_details(@get_express_checkout_details)
    
    # Access Response
    if @get_express_checkout_details_response.success?
      @get_express_checkout_details_response.GetExpressCheckoutDetailsResponseDetails
    else
      @get_express_checkout_details_response.Errors
    end

    @amt = @get_express_checkout_details_response.GetExpressCheckoutDetailsResponseDetails.PaymentDetails[0].OrderTotal.value
    @payerid = params[:PayerID] #@req.body.split("PAYERID=")[1].split("&")[0]

    @do_express_checkout_payment = @api.build_do_express_checkout_payment({
      :DoExpressCheckoutPaymentRequestDetails => {
        :PaymentAction => "Sale",
        :Token => @token,
        :PayerID => @payerid,
        :PaymentDetails => [{
          :OrderTotal => {
            :currencyID => "USD",
            :value => @amt },
        }] } })

    # Make API call & get response
    @do_express_checkout_payment_response = @api.do_express_checkout_payment(@do_express_checkout_payment)
    
    # Access Response
    if @do_express_checkout_payment_response.success?
      @do_express_checkout_payment_response.DoExpressCheckoutPaymentResponseDetails
      @do_express_checkout_payment_response.FMFDetails
      @ret = @do_express_checkout_payment_response.Ack
    else
      @ret = @do_express_checkout_payment_response.Errors.join
    end
    render text: @ret
  end
  
end
