require_relative '../lib/selector'

describe Selector, :selector do
  it "returns the constructor argument" do
    Selector.new(:to_s).selector.should == :to_s
  end

  it "returns a Symbol" do
    Selector.new('[]').selector.should == :[]
  end
end


describe Selector, :receivers do
  it "returns the classes and modules whose instances respond to the selector" do
    Selector.new(:i).receivers.all? do |c|
      c.instance_methods.should include(:i)
    end
  end

  it "returns an empty Array for selectors which nothing responds to" do
    Selector.new(:gltryu).receivers.should == []
  end
end

describe Selector, :unary? do
  it "returns true if the selector always has an arity of 0" do
    Selector.new(:size).should be_unary
  end

  it "returns false if the selector doesn't always have an arity of 0" do
    Selector.new(:[]).should_not be_unary
  end
end

describe Selector, :binary? do
  it "returns true if the selector always has an arity of 1" do
    Selector.new(:+).should be_binary
  end

  it "returns false if the selector doesn't always have an arity of 0" do
    Selector.new(:to_s).should_not be_binary
  end
end
