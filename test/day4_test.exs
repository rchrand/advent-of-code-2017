defmodule AdventOfCode2017.Day4Test do
  use ExUnit.Case

  test "check the given examples" do
    assert AdventOfCode2017.Day4.call("aa bb cc dd ee") == 1
    assert AdventOfCode2017.Day4.call("aa bb cc dd aa") == 0
    assert AdventOfCode2017.Day4.call("aa bb cc dd aaa") == 1
    assert AdventOfCode2017.Day4.call("aa bb cc dd aaa
    aa bb cc dd aa") == 1
  end
end
