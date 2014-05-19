#Implementation
#       Provides an object as a surrogate for the lack of an object of a given type.
#       Provides intelligent do nothing behavior, hiding the details from its collaborators
#
#Collaborators
#       AbstractClass:{}
#           defines abstract primitive operations that concrete implementations have to define
#       RealClass::{}
#           a real implementation of the AbstractClass performing some real actions
#       NullClass::{}
#            a implementation which do nothing of the abstract class, in order to 
#            provide a non-null object to the client
#       Client::{}
#            The client gets an implementation of the abstract class and uses it. 
#            It doesn't really care if the implementation is a null object or 
#            an real object since both of them are used in the same way
#
#Applicability & Examples
#       Log System
#       Removing old functionality
#           The Null Object can be used to remove old functionality by replacing 
#           it with null objects. The big advantage is that the existing code doesn't 
#           need to be touched.
#
#
#Related Patterns
#       Null Object and Factory
#           The Null Object design pattern is more likely to be used in conjunction 
#           with the Factory pattern. The reason for this is obvious: A Concrete Classes 
#           need to be instantiated and then to be served to the client. The client uses 
#           the concrete class. The concrete class can be a Real Object or a Null Object.
#       Null Object and Template Method
#           The Template method design pattern need to define an abstract class that define 
#           the template and each concrete class implements the steps for the template. 
#           If there are cases when sometimes template is called and sometimes not then, 
#           in order to avoid the checking a Null Object can be use to implement a 
#           Concrete Template that does nothing.
#
require "singleton"
module Null
  def self.included(base)
    base.send(:include, Singleton)
  end

  def to_a; []; end
  def to_ary; []; end
  def to_s; ""; end
  def to_f; 0.0; end
  def to_i; 0; end
  def nil?; true; end

  def inspect
    "#<%s:0x%x>" % [self.class, object_id]
  end

  def method_missing(*args, &block)
    self
  end

  def respond_to?(message, include_private=false)
    true
  end

end

class Object
  include Null
end



