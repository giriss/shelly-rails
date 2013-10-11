class LearnController < ApplicationController
  
  require 'net/http'
  skip_before_action :verify_authenticity_token, only: [:lesson3]
  
  def lesson1
  end

  def lesson2
    uri = URI "http://akh-rails.herokuapp.com/learn/lesson3"
    res = Net::HTTP.post_form uri, :name => params[:name]
    render text: "Hi " + res.body
  end

  def lesson3
    if params[:name] then
      @name = params[:name]
    else
      @name = :default
    end
    render text: "Hello " + @name
  end
end
