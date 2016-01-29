

# My Merge

## Objective

You will be building out Ruby's `#merge` method. You'll be monkey patching the Array class to do this.

## About Merge

Ruby's `merge` method takes either one argument, a hash, and an optional a block. 

It returns a new hash containing the contents of both the hash it is called on and the hash it is passed as an argument. 

If it's not passed a block and there are duplicate keys, the values for the keys in the hash passed as an argument are prioritized.

Otherwise the value for each duplicate key is determined by calling the block with the key, its value in hash the method is called on and its value in hash passed as an argument.

Here's what `#merge` does when it's called on without a block and there are no dupliated keys:

```ruby

h1 = { "a" => 1, "b" => 2 }
h2 = { "c" => 3, "d" => 4 }

h1.merge(h2)
#=> {"a"=>1, "b"=>2, "c"=>3, "d"=>4}
```

Here's what `#merge` does when it's called on without a block and there are dupliated keys:

```ruby
h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }

h1.merge(h2)
#=> {"a"=>100, "b"=>254, "c"=>300}
```

Here's what merge does when it's passed a block along with an argument:

```ruby
h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }

h1.merge(h2) { |key, oldval, newval| newval - oldval }
#=> {"a"=>100, "b"=>54,  "c"=>300}
```

## Notes

You may not call on Ruby's `#merge` method to accomplish this task. Do not change the hash that `#merge` is called on and do not change the hash it is passed as an argument. You will not need to use `#clone` to accomplish this.

## Resources

* [Ruby's Merge Method](http://ruby-doc.org/core-2.1.5/Hash.html#method-i-merge)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/my-merge' title='My Merge'>My Merge</a> on Learn.co and start learning to code for free.</p>
