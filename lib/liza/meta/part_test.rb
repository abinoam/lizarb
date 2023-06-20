class Liza::PartTest < Liza::Test
  test :subject_class do
    assert subject_class == Liza::Part
  end

  #

  test :subject_class, :defined_methods do
    assert_equality subject_class.defined_methods, [:extension, :insertion]
  end

  test :subject_class, :defined_instance_methods do
    assert_equality subject_class.defined_instance_methods, []
  end

  #

end
