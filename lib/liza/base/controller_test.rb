class Liza::ControllerTest < Liza::UnitTest
  test :subject_class do
    assert subject_class == Liza::Controller
  end

  test :settings do
    assert subject_class.log_level == :normal
    assert subject_class.log_color == :white
  end

  test :subject_class, :defined_methods do
    assert_equality subject_class.defined_methods, [:on_connected, :panel, :box, :controller_methods, :controller_instance_methods, :renderer, :controller_ancestors, :render_paths, :renderers, :puts]
  end

  test :subject_class, :defined_instance_methods do
    assert_equality subject_class.defined_instance_methods, [:_log_render_in, :render_paths, :box, :panel, :renderer, :render]
  end

end
