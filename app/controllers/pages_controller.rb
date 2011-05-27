class PagesController < ApplicationController

  def welcome
    @welcome_class = 'current'
  end

  def about
    @about_class = 'current'
  end

  def contact
    @contact_class = 'current'
  end
  
end
