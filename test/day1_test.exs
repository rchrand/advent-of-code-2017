defmodule AdventOfCode2017.Day1Test do
  use ExUnit.Case

  test "passes the given examples" do
    assert AdventOfCode2017.Day1.call("1122") == 3
    assert AdventOfCode2017.Day1.call("1111") == 4
    assert AdventOfCode2017.Day1.call("1234") == 0
    assert AdventOfCode2017.Day1.call("91212129") == 9
  end
end
