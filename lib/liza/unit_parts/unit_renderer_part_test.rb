class Liza::UnitRendererPartTest < Liza::UnitTest

  test :defined_erbs do
    defined_erbs = Unit.defined_erbs.map(&:key)
    expected = []
    assert_equality defined_erbs, expected
  end

  test :available_erbs do
    available_erbs = Unit.available_erbs
    expected = []
    assert_equality available_erbs.keys, expected
  end

end
