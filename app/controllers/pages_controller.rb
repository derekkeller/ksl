class PagesController < ApplicationController

  def welcome
    @welcome_class = 'current'
    @current_banner = 'header_welcome'
    @footer_image = 'footer_welcome'
  end

  def about
    @about_class = 'current'
    @footer_image = 'footer_about'
  end

  def contact
    @contact_class = 'current'
    @current_banner = 'header_contact'
    @footer_image = 'footer_contact'
  end

end
