require 'spec_helper'

# This is the _simplest_ version of an Either 'monad', it does the job of providing context whether 
# the operation succeeded or failed. For a more complete see the [Deterministic gem](http://github.com/pzol/deterministic).
# This is more useful, than simply returning a nil, without an explanation in case of failure
class Either
  attr_reader :value
  def initialize(value)
    @value = value
  end

  def ==(other)
    self.class == other.class && self.value == other.value
  end

  class Success < Either; end
  class Failure < Either; end
end

module DoWork
  # flow control, error checking here
  def self.call(arg)
    result = work(arg)
    result == 1 ? Either::Success.new(1) : Either::Failure.new('something went terribly wrong')
  end

private
  # real work here
  def self.work(arg)
    arg
  end
end

describe DoWork do
  specify { expect(DoWork.call(1)).to eq Either::Success.new(1) }
  specify { expect(DoWork.call(2)).to eq Either::Failure.new('something went terribly wrong') }
  specify { expect(DoWork.call(1).is_a?(Either::Success)).to be true }
end
