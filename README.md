# tuple-has

Bare-bones extensible product, aka tuples.

## What it provides

A single module `Data.Tuple.Has` with a single type class `Has`:

```
class Has s a where
  field :: Functor f => (a -> f a) -> s -> f s
```

`field` is a van-Laarhoven lens of a single field in a tuple. The type is compatible with `lens`/`microlens`, and can be used as a getter/setter.

Compilation takes a minute or two, since instances for all fields of all possible tuple types (up to 62-tuple) are generated.

## Credits

Directly inspired by [winterland1989](https://github.com/winterland1989)'s [data-has](https://github.com/winterland1989/data-has).
