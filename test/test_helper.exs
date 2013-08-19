ExUnit.start

defmodule EnumCompare do
  use ExUnit.Case

  defmacro assert_enum(function, collection, fun, options // []) do
    parallel = quote do
      Parallel.unquote(function)(unquote(collection), unquote(fun))
    end
    enum = quote do
      Enum.unquote(function)(unquote(collection), unquote(fun))
    end
    if Keyword.get(options, :sort) do
      parallel = quote do: Enum.sort(unquote(parallel))
      enum = quote do: Enum.sort(unquote(enum))
    end
    quote do: assert unquote(enum) == unquote(parallel)
  end
end

