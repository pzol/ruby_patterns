require 'spec_helper'

# The ObjectBuilder is a simple idea to nicely build an object
class ObjectBuilder
  attr_accessor :one, :two, :three
  def initialize(&block)
    instance_eval(&block)
  end
end

describe ObjectBuilder do
    subject {
      ObjectBuilder.new do |o|
        o.one   = 1
        o.two   = 2
        o.three = 3
      end
    }

    specify { 
      expect(subject.one).to   eq 1
      expect(subject.two).to   eq 2
      expect(subject.three).to eq 3 
    }
end
