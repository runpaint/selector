class Selector
  attr_accessor :selector

  def initialize(selector)
    @selector = selector.to_sym
  end

  def receivers
    @receivers ||= Object.constants.
      map{|c| Object.const_get(c)}.
      select{|o| [Class, Module].any? {|c| o.is_a?(c) }}.
      select{|o| o.method_defined?(selector) }
  end
  
  def binary?
    arity? 1
  end

  def unary?
    arity? 0
  end

  private
  def arity?(arity)
    return false if receivers.empty?
    receivers.map{|r| r.instance_method(selector)}.all?{|m| m.arity == arity}
  end
end
