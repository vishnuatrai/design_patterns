#Implementation
#       The intent of this pattern is to decouple abstraction from implementation 
#       so that the two can vary independently.
#       An Abstraction can be implemented by an abstraction implementation, and this 
#       implementation does not depend on any concrete implementers of the Implementor 
#       interface. Extending the abstraction does not affect the Implementor. Also extending 
#       the Implementor has no effect on the Abstraction.
#       The bridge pattern applies when there is a need to avoid permanent binding 
#       between an abstraction and an implementation and when the abstraction and 
#       implementation need to vary independently. Using the bridge pattern would leave 
#       the client code unchanged with no need to recompile the code.
#
#Collaborators
#       Abstraction::{}
#           Abstraction defines abstraction interface.
#       AbstractionImpl::{}
#           Implements the abstraction interface using a reference to an object of 
#           type Implementor.
#       Implementor::{}
#           Implementor defines the interface for implementation classes. 
#           This interface does not need to correspond directly to abstraction 
#           interface and can be very different. Abstraction imp provides an 
#           implementation in terms of operations provided by Implementor interface.
#       ConcreteImplementor::{}
#           Implements the Implementor interface.
#
#Applicability & Examples
#       Object Persistence API Example
#       Graphical User Interface Frameworks
#
#Related Patterns
#       Abstract Factory Pattern - An Abstract Factory pattern can be used create and 
#       configure a particular Bridge, for example a factory can choose the suitable 
#       concrete implementor at runtime.
#

