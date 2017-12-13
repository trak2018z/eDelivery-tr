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

  def price_of_package_element
    {weight: 1, height: 0.07, width: 0.07, length: 0.07}
  end



end
