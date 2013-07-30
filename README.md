# Parallel

A library that implements Elixir's `Enum` interface but parallelized.

```
iex> Enum.map(1..10, fn _ -> :timer.sleep(1000) end)
# Takes 10 seconds
[:ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok]
iex> Parallel.map(1..10, fn _ -> :timer.sleep(1000) end)
# Takes 1 second
[:ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok]
```
