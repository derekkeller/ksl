class PagesController < ApplicationController

  def welcome
    @welcome_class = 'current'
    @current_banner = 'header_welcome'
  end

  def about
    @about_class = 'current'
  end

  def contact
    @contact_class = 'current'
    @current_banner = 'header_contact'
  end
  
end
