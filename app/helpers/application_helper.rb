module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Clinic App'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def logged_in?
    AuthenticationService.new(session).logged_in?
  end

  def secretary?
    AuthenticationService.new(session).current_user.secretary?
  end

  def doctor? 
    AuthenticationService.new(session).current_user.doctor?
  end
end
