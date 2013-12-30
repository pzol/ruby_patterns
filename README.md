Ruby Patterns
=============

Those are application patterns recommended and frequently used by me in my apps. The aim is not to provide the standard GOF patterns, but real life snippets for scenarios I came across frequently. 

Some of the examples, might not be the simplest to follow, this might be due the fact, that I was trying to make them no the typical over-simplified blog examples, but close to real life situations.

All examples can be found in the specs. The implementations are kept within the specs - this is the way I always start an implementation, first write spec and implementation in one file, only if it's done, move it to its own file and include in the general codebase.

## General Guidelines
### Errors
Errors should be nested in a module in your library or app.

```ruby
module RubyPatterns
  class MyError < StandardError; end
end
```

### Specs

#### described_class
In the `describe` prefer adding a type instead of a string description for __unit tests__. Here I refer to `RubyPatters::MyError` to make sure the class actually exists. Also use `described_class` to refer to that class. If you change the name, you have to change it only in one place.

```ruby
describe RubyPatterns::MyError do
  specify{
    expect { raise described_class }.to_raise described_class
  }
end
```
References:
 * [spec/examples/parse_params_spec.rb](spec/examples/parse_params_spec.rb)

### Units of Work
 * small units of work
 * one class or module per activity (SRP)

### One Module for a Use Case Group

## Examples

## Inner Exception
Now Ruby 2.1 has brought the `#cause` method with the inner exception, if you're on an earlier version of ruby, use this:

```ruby
class ParseParamsError < StandardError
  attr_reader :inner
  def initialize(msg, inner=$ERROR_INFO)
    super(msg)
    @inner = inner
  end
end
```

References:
 * [spec/examples/parse_params_spec.rb](spec/examples/parse_params_spec.rb)
 * [Exception Causes in Ruby 2.1](http://devblog.avdi.org/2013/12/25/exception-causes-in-ruby-2-1/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
