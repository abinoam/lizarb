# frozen_string_literal: true

class Module

  # /path/to/liza.rb
  def source_location
    Array Object.const_source_location name
  end

  # /path/to/liza
  def source_location_radical
    source_location[0][0..-4]
  rescue
    nil
  end

  #

  def defined_methods
    methods(false)
  end

  def defined_instance_methods
    instance_methods(false)
  end

end
