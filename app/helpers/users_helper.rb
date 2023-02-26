module UsersHelper
  def get_name(user)
    if !user.first_name.blank? && !user.last_name.blank?
      "#{user.first_name} #{user.last_name}"
    elsif !user.first_name.blank?
      user.first_name
    elsif !user.last_name.blank?
      user.last_name
    else
      user.email[0,2].upcase
    end
  end

  def format_time(time)
    time.strftime("%d/%m/%Y")
  end
end
       