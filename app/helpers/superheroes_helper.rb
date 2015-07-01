module SuperheroesHelper

  def display_present_attribute(name, value)
    if value.present?
        name + ":  " +  value
      end
  end
end
