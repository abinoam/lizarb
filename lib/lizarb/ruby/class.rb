# frozen_string_literal: true

class Class
  public :eval

  def descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def first_namespace
    name.rpartition('::')[0]
  end

  def last_namespace
    name.rpartition('::')[-1]
  end

  #

  def defined_methods
    methods(false) - superclass.methods(false)
  end

  def defined_instance_methods
    instance_methods(false) - superclass.instance_methods(false)
  end

end
