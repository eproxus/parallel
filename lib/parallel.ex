defmodule Parallel do

  def map(list, func, options // []) do
    list = Enum.to_list(list) # TODO: Can we be generic?
    len = length(list)
    size = Keyword.get(options, :size) || if(len < 10, do: len, else: 10)
    pool = pool(size)
    execute list, func, pool
  end

  # Private

  defp execute(list, func, pool) do execute list, func, pool, [], [] end

  defp execute([], _func, _pool, [], result) do
    # TODO: Kill pool
    result
  end
  defp execute([item|list], func, [pid|pool], busy, acc) do
    pid <- {self, func, item}
    execute list, func, pool, [pid|busy], acc
  end
  defp execute(list, func, pool, busy, result) do
    receive do
      {from, item} ->
        execute list, func, [from|pool], List.delete(busy, from), [item|result]
    end
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
    lc pid inlist :lists.seq(1, size), do: spawn_link(function worker/0)
  end

end
