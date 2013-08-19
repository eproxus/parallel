defmodule Parallel do

  def map(collection, fun, options // []) do
    run(collection, fun, options, [], fn item, acc -> [item|acc] end)
  end

  def each(collection, fun, options // []) do
    run(collection, fun, options, nil, fn _item, nil -> nil end)
  end

  def any?(collection, fun, options // []) do
    run(collection, fun, options, false, fn item, value -> item || value end)
  end

  # Private

  defp run(collection, fun, options, acc, update) do
    acc = {pool(fun, options), [], acc, update}
    {_, busy, acc, _} = Enumerable.reduce(collection, acc, function(execute/2))
    consume(busy, acc, update)
  end

  defp execute(item, {free = [], busy, acc, update}) do
    receive do
      {ref, from, result} ->
        from <- {ref, self(), item}
        {free, busy, update.(result, acc), update}
    end
  end
  defp execute(item, {[worker = {ref, pid}|free], busy, acc, update}) do
    pid <- {ref, self(), item}
    {free, [worker|busy], acc, update}
  end

  defp consume(pool, acc, update) do
    Enum.reduce(pool, acc, fn {ref, pid}, acc ->
      receive do
        {^ref, ^pid, result} -> update.(result, acc)
      end
    end)
  end

  def worker(fun) do
    receive do
      {ref, sender, item} ->
        sender <- {ref, self, fun.(item)}
        worker(fun)
      :exit ->
        :ok
    end
  end

  defp pool(fun, options) do
    size = Keyword.get(options, :size) || :erlang.system_info(:schedulers) * 2
    spawn_worker = fn -> {make_ref(), spawn_link(fn -> worker(fun) end)} end
    Stream.repeatedly(spawn_worker) |> Enum.take(size)
  end

end
