# Parallel

A library that implements Elixir's `Enum` interface but parallelized.

```elixir
:timer.tc fn -> Enum.map 1..10, fn i -> :timer.sleep(1000) end end
# -> {10010674, [:ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok]}
# Run time is 10 seconds
:timer.tc fn -> Parallel.map 1..10, fn i -> :timer.sleep(1000) end, size: 10 end
# -> {1001653, [:ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok]}
# Run time is 1 second
```

# TODO

- Implement all Enum functions
    - `all?/2`
    - `any?/2`
    - `at/3`
    - `count/1`
    - `count/2`
    - `drop/2`
    - `drop_while/2`
    - ~~`each/2`~~ **Done**
    - `empty?/1`
    - `fetch/2`
    - `fetch!/2`
    - `filter/2`
    - `filter_map/3`
    - `find/3`
    - `find_index/2`
    - `find_value/3`
    - `first/1`
    - `join/2`
    - ~~`map/2`~~ **Done**
    - `map_join/3`
    - `map_reduce/3`
    - `max/1`
    - `max/2`
    - `member?/2`
    - `min/1`
    - `min/2`
    - `partition/2`
    - `reduce/3`
    - `reject/2`
    - `reverse/1`
    - `shuffle/1`
    - `sort/1`
    - `sort/2`
    - `split/2`
    - `split_while/2`
    - `take/2`
    - `take_while/2`
    - `to_list/1`
    - `uniq/2`
    - `with_index/1`
    - `zip/2`
- Investigate [Stream](http://elixir-lang.org/docs/stable/Stream.html)
  compatibility (option `stream: true`?)
