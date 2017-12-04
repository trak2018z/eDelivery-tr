module ApplicationHelper
  def flash_class(level)
    case level
      when "notice" then "alert alert-info"
      when "success" then "alert alert-success"
      when "error" then "alert alert-danger"
      when "errors" then "alert alert-danger"
      when "notice" then "alert alert-info"
      when "alert" then "alert alert-danger"
    end
  end

end
