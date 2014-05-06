#Implementation
#       Add additional responsibilities dynamically to an object.
#       The decorator pattern applies when there is a need to dynamically add as well as
#       remove responsibilities to a class, and when subclassing would be impossible 
#       due to the large number of subclasses that could result.
#
#Collaborators
#       Component::{},
#           Interface for objects that can have responsibilities added to them dynamically
#       ConcreteComponent::{}
#           Defines an object to which additional responsibilities can be added
#       Decorator::{}
#           Maintains a reference to a Component object and defines an interface 
#           that conforms to Component's interface
#       ConcreteDecorator::{}
#           Concrete Decorators extend the functionality of the component by adding 
#           state or adding behavior
#
#Applicability & Examples
#       Extending capabilities of a Graphical Window at runtime
#
#Related Patterns
#       Adapter Pattern - A decorator is different from an adapter in that a decorator 
#       changes object's responsibilities, while an adapter changes an object interface.
#       Composite Pattern - A decorator can be viewed as a degenerate composite with 
#       only one component. However, a decorator adds additional responsibilities.
#
#
