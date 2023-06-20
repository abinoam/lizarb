class Liza::SystemTest < Liza::UnitTest
  test :subject_class do
    assert subject_class == Liza::System
  end

  test :settings do
    assert subject_class.log_level == :normal
    assert subject_class.log_color == :white
  end

  #

  test :subject_class, :defined_methods do
    assert_equality subject_class.defined_methods, [:system_methods, :system_instance_methods, :registrar, :const, :insertion]
  end

  test :subject_class, :defined_instance_methods do
    assert_equality subject_class.defined_instance_methods, []
  end

  #

end
