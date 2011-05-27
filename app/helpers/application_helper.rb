module ApplicationHelper

  def class_type
    if current_user.present?
      if current_user.admin?
        "top_menu_admin"
      end
    "top_menu"
    end
    "top_menu"
  end

  def formatted_date(date)
    if date > Time.now.beginning_of_day
      return date.strftime("%l:%M%p")
    end
    date.strftime("%b %d")  
  end

  def time_since_post(date)
    return time_ago_in_words(date)
  end

  def nh(n,p=0)
    number_to_currency(n, :precision => p)
  end
    
end
