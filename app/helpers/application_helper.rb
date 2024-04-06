module ApplicationHelper
  def format_time(time)
    time.strftime("%H:%M") if time.present?
  end
end
