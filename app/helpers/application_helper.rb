module ApplicationHelper
  def title 
    base_title = "M Hartl's awesome app"
    @title.nil? ? base_title : (base_title + " - " + @title).strip
  end
end
