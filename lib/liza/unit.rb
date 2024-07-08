class Liza::Unit

  # ERROR
  
  class Error < Liza::Error; end

  # PART

  def self.part key, klass = nil, system: nil
    part_class ||= if system.nil?
                Liza.const "#{key}_part"
              else
                Liza.const("#{system}_system")
                    .const "#{key}_part"
              end
    self.class_exec(&part_class.insertion) if part_class.insertion
  end

  # CONST MISSING

  def self.const_missing name
    Liza.const name
  rescue Liza::ConstNotFound
    if Lizarb.ruby_supports_raise_cause?
      raise NameError, "uninitialized constant #{name}", caller[1..], cause: nil
    else
      raise NameError, "uninitialized constant #{name}", caller
    end
  end

  # PARTS

  part :unit_logging

  part :unit_methods

  class RenderError < Error; end
  class RendererNotFound < RenderError; end
  class RenderStackIsFull < RenderError; end
  class RenderStackIsEmpty < RenderError; end
  part :unit_renderer

  part :unit_setting

  def self.subclasses_select system:
    subclasses.select { _1.system? system }
  end

  def self.descendants_select system:
    descendants.select { _1.system? system }
  end

  def self.namespace
    return @namespace if defined? @namespace

    @namespace ||= Object unless to_s.include? "::"
    @namespace ||= Liza if to_s.start_with? "Liza::"
    @namespace ||= system
    @namespace
  end

  def self.system? system
    system = Liza.const "#{system}_system" if system.is_a? Symbol
    system == get(:system)
  end

  def self.reload!
    Lizarb.reload
  end

  def reload!
    Lizarb.reload
  end

  # TEST

  def self.test_class
    @test_class ||=
      if first_namespace == "Liza"
        Liza.const_get "#{last_namespace}Test"
      else
        Object.const_get "#{name}Test"
      end
  end

  # CONTROLLER

  def self.division
    Liza::Controller
  end

  # SYSTEM

  def self.system
    if name&.include? "::"
      return System if first_namespace == "Liza"
      Object.const_get first_namespace
    else
      superclass.system
    end
  end

  singleton_class.send :public, :system

  def system
    self.class.system
  end

  public :system

  #

  set :log_level, App.log_level
  set :division, Liza::Controller
  
end

__END__

# view render.txt.erb
<%= render if render_stack.any? -%>
