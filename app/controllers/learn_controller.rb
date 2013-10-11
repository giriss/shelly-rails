class LearnController < ApplicationController
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
