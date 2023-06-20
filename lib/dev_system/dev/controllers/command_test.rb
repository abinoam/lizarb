class DevSystem::CommandTest < Liza::ControllerTest

  test :subject_class do
    assert subject_class == DevSystem::Command
  end

  test :settings do
    assert subject_class.log_level == :normal
    assert subject_class.log_color == :green
  end

  #

  test :subject_class, :defined_methods do
    assert_equality subject_class.defined_methods, [:call, :command_methods, :command_instance_methods]
  end

  test :subject_class, :defined_instance_methods do
    assert_equality subject_class.defined_instance_methods, [:call]
  end

  #

end
