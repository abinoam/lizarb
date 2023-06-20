class Liza::BoxTest < Liza::UnitTest
  test :subject_class do
    assert subject_class == Liza::Box
  end

  test :settings do
    assert subject_class.log_level == :normal
    assert subject_class.log_color == :white
  end

  test :subject_class, :defined_methods do
    assert_equality subject_class.defined_methods, [:panels, :has_panel, :has_controller, :box_methods, :box_instance_methods, :[], :puts, :configure]
  end

  test :subject_class, :defined_instance_methods do
    assert_equality subject_class.defined_instance_methods, []
  end

end
