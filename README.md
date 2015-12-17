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

* [ ] Implement all Enum functions
  * [x] `all?(collection, fun \\ fn x -> x end)`
  * [x] `any?(collection, fun \\ fn x -> x end)`
  * [ ] `at(collection, n, default \\ nil)`
  * [ ] `chunk(collection, n)`
  * [ ] `chunk(collection, n, step, pad \\ nil)`
  * [ ] `chunk_by(collection, fun)`
  * [ ] `concat(enumerables)`
  * [ ] `concat(left, right)`
  * [ ] `count(collection)`
  * [ ] `count(collection, fun)`
  * [ ] `dedup(collection)`
  * [ ] `dedup_by(collection, fun)`
  * [ ] `drop(collection, count)`
  * [ ] `drop_while(collection, fun)`
  * [x] `each(collection, fun)`
  * [ ] `empty?(collection)`
  * [ ] `fetch(collection, n)`
  * [ ] `fetch!(collection, n)`
  * [ ] `filter(collection, fun)`
  * [ ] `filter_map(collection, filter, mapper)`
  * [ ] `find(collection, default \\ nil, fun)`
  * [ ] `find_index(collection, fun)`
  * [ ] `find_value(collection, default \\ nil, fun)`
  * [ ] `flat_map(collection, fun)`
  * [ ] `flat_map_reduce(collection, acc, fun)`
  * [ ] `group_by(collection, dict \\ %{}, fun)`
  * [ ] `intersperse(collection, element)`
  * [ ] `into(collection, list)`
  * [ ] `into(collection, list, transform)`
  * [ ] `join(collection, joiner \\ "")`
  * [x] `map(collection, fun)`
  * [ ] `map_join(collection, joiner \\ "", mapper)`
  * [ ] `map_reduce(collection, acc, fun)`
  * [ ] `max(collection)`
  * [ ] `max_by(collection, fun)`
  * [ ] `member?(collection, value)`
  * [ ] `min(collection)`
  * [ ] `min_by(collection, fun)`
  * [ ] `min_max(collection)`
  * [ ] `min_max_by(collection, fun)`
  * [ ] `partition(collection, fun)`
  * [ ] `random(collection)`
  * [ ] `reduce(collection, fun)`
  * [ ] `reduce(collection, acc, fun)`
  * [ ] `reduce_while(collection, acc, fun)`
  * [ ] `reject(collection, fun)`
  * [ ] `reverse(collection)`
  * [ ] `reverse(collection, tail)`
  * [ ] `reverse_slice(collection, start, count)`
  * [ ] `scan(enum, fun)`
  * [ ] `scan(enum, acc, fun)`
  * [ ] `shuffle(collection)`
  * [ ] `slice(collection, range)`
  * [ ] `slice(collection, start, count)`
  * [ ] `sort(collection)`
  * [ ] `sort(collection, fun)`
  * [ ] `sort_by(collection, mapper, sorter \\ &<=/2)`
  * [ ] `split(collection, count)`
  * [ ] `split_while(collection, fun)`
  * [ ] `sum(collection)`
  * [ ] `take(collection, count)`
  * [ ] `take_every(collection, nth)`
  * [ ] `take_random(collection, count)`
  * [ ] `take_while(collection, fun)`
  * [ ] `to_list(collection)`
  * [ ] `uniq(collection)`
  * [ ] `uniq_by(collection, fun)`
  * [ ] `unzip(collection)`
  * [ ] `with_index(collection)`
  * [ ] `zip(collection1, collection2)`
* [ ] Short circuit relevant functions (`any?/2`, `find/3` etc.)
* [ ] Investigate [Stream](http://elixir-lang.org/docs/v1.1/elixir/Stream.html)
  compatibility (option `stream: true`?)
* [ ] Decide on implementing all functions or just relevant ones (e.g. `first/1`)
* [ ] Add documentation
* [ ] Add `link: false` option
* [ ] Add `sorted: true` option
