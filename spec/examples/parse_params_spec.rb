require 'spec_helper'

# One of the simplest ways to sanitize a hash of incoming params, without external libraries and meta-programming
class ParseParams
  def initialize(dirty)
    @dirty = dirty
  end

  # This will actually build the result. It will return a Hash if successful, or nil if not.
  # An optional block passed can be used for error reporting
  def call(&callback)
    begin
      build
    rescue => ex
      yield(ex) if block_given?
      nil
    end
  end

private
  attr_reader :dirty

  # A private build method, which does the actual work
  def build
    # use guard clauses to a) avoid nested ifs b) early identify invalid values
    raise ArgumentError, "`a` must be a Fixnum" unless dirty.fetch(:a).is_a? Fixnum

    # #tap will guarantee, that a hash is returned
    {}.tap do |h|
      h[:a] = dirty.fetch(:a)                       # a mandatory parameter, will raise a KeyError on violation
      h[:b] = dirty.fetch(:b, 2)                    # optional, with 2 as the default
      h[:c] = dirty.fetch(:c) if dirty.has_key? :c  # optional, no default
    end
  end
end

describe ParseParams do
  it 'sunny day' do
    params = ParseParams.new({a: 1}).call {|ex| puts ex }

    expect(params).not_to           be_nil
    expect(params.fetch(:a)).to     eq 1
    expect(params.fetch(:b)).to     eq 2
    expect(params.has_key?(:c)).to  be_falsey
  end

  it 'the callback allows to react to errors' do
    error  = nil
    params = ParseParams.new({}).call {|ex| error = ex }

    expect(error).to be_a KeyError
    expect(params).to be_nil
  end
end
