module ApplicationHelper
  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end

  def icon_link(link_path, icon)
    link_to raw("<i class='material-icons'>#{icon}</i>"), link_path
  end
end
