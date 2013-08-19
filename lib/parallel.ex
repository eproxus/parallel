defmodule Parallel do

  def map(collection, fun, options // []) do
    len = Enumerable.count(collection)
    size = Keyword.get(options, :size) || if(len < 10, do: len, else: 10)
    free = pool(size)
    acc = {fun, free, [], []}
    {_, _, busy, acc} = Enumerable.reduce(collection, acc, function(execute/2) )
    List.concat(acc, consume(busy))
  end

  # Private

  defp execute(item, {func, free = [], busy, acc}) do
    receive do
      {from, result} ->
        from <- {self(), func, item}
        {func, free, busy, [result|acc]}
    end
  end
  defp execute(item, {func, [pid|free], busy, acc}) do
    pid <- {self(), func, item}
    {func, free, [pid|busy], acc}
  end

  defp consume(pool) do
    Enum.map(pool, fn pid ->
      receive do
        {^pid, result} -> result
      end
    end)
  end

  defp worker do
    receive do
      {sender, func, item} when is_function(func) ->
        sender <- {self, func.(item)}
        worker
      :exit ->
        :ok
    end
  end

  defp pool(size) do
    Stream.repeatedly(function(spawn_worker/0)) |> Enum.take(size)
  end

  defp spawn_worker do
    spawn_link(function(worker/0))
  end

end
