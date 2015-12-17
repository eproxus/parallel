Code.require_file "test_helper.exs", __DIR__

defmodule ParallelTest do
  use ExUnit.Case

  import EnumCompare
  import Parallel

  test :map do
    assert_enum :map, 1..10, &(&1 + 1), sort: true
  end

  test :random_map do
    :random.seed(:erlang.now())
    Enum.each 1..50, fn _ ->
      list = Enum.map 1..50, &:random.uniform/1
      assert_enum :map, list, &(&1 + 1), sort: true
    end
  end

  test :each do
    pid = self()
    collection = 1..10
    each(collection, fn i -> send(pid, {:test, i}) end)
    Enum.each(collection, fn i ->
      receive do
        {:test, ^i} -> :ok
      after 100 ->
        assert false, "No result received"
      end
    end)
  end

  test :any? do
    assert_enum :any?, [false, true], fn b -> b end
  end

end
