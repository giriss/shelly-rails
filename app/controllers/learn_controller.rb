class LearnController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:lesson3]
  def lesson1
  end

  def lesson2
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
