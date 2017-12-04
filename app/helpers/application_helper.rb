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

  def eDelivery_currency(value)
    number_to_currency value, unit: "£", seperator: ",", delimiter: ""
  end

  def price_of_package_element
    {weight: 3, height: 1.23, width: 0.59, length: 1}
  end

end
