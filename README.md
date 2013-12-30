Ruby Patterns
=============

Those are application patterns recommended and frequently used by me in my apps. The aim is not to provide the standard GOF patterns, but real life snippets for scenarios I came across frequently. 

Some of the examples, might not be the simplest to follow, this might be due the fact, that I was trying to make them no the typical over-simplified blog examples, but close to real life situations.

All examples can be found in the specs. The implementations are kept within the specs - this is the way I always start an implementation, first write spec and implementation in one file, only if it's done, move it to its own file and include in the general codebase.

## General Guidelines
### Units of Work
 * small units of work
 * one class or module per activity (SRP)

### One Module for a Use Case Group

## Examples

## Inner Exception
Now Ruby 2.1 has brought the `#cause` method with the inner exception, if you're on an earlier version of ruby, use this:

See [spec/examples/parse_params_spec.rb](spec/examples/parse_params_spec.rb).

```ruby
class ParseParamsError < StandardError
  attr_reader :inner
  def initialize(msg, inner=$ERROR_INFO)
    super(msg)
    @inner = inner
  end
end
```

See also [Exception Causes in Ruby 2.1](http://devblog.avdi.org/2013/12/25/exception-causes-in-ruby-2-1/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
