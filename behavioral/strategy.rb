#Implementation
#       Define a family of algorithms, encapsulate each one, and make them interchangeable. 
#       Strategy lets the algorithm vary independently from clients that use it.
#       The Context objects contains a reference to the ConcreteStrategy that should be used. 
#       When an operation is required then the algorithm is run from the strategy object. 
#       The Context is not aware of the strategy implementation. If necessary, addition objects 
#       can be defined to pass data from context object to strategy. 
#       The context object receives requests from the client and delegates them to the strategy object. 
#       Usually the ConcreteStartegy is created by the client and passed to the context. 
#       From this point the clients interacts only with the context.
#       The strategy design pattern splits the behavior (there are many behaviors) of a class 
#       from the class itself. This has some advantages, but the main draw back is that 
#       a client must understand how the Strategies differ. Since clients get exposed to 
#       implementation issues the strategy design pattern should be used only when the variation 
#       in behavior is relevant to them.
#
#Collaborators
#       Strategy::{}
#           defines an interface common to all supported algorithms. 
#           Context uses this interface to call the algorithm defined by a ConcreteStrategy.
#       ConcreteStrategy::{}
#           each concrete strategy implements an algorithm.
#       Context::{}
#           contains a reference to a strategy object
#           may define an interface that lets strategy accessing its data
#       
#Applicability & Examples
#       Robots Application
#
#Specific problems and implementation
#       Passing data to/from Strategy object
#       Families of related algorithms.
#       Optionally Concrete Strategy Objects
#       Strategy and Creational Patterns
#           In the classic implementation of the pattern the client should be aware of 
#           the strategy concrete classes. In order to decouple the client class from strategy 
#           classes is possible to use a factory class inside the context object to create 
#           the strategy object to be used. By doing so the client has only to send a parameter 
#           (like a string) to the context asking to use a specific algorithm, being totally 
#           decoupled of strategy classes.
#       Strategy and Bridge
#           Both of the patterns have the same UML diagram. But they differ in their intent since 
#           the strategy is related with the behavior and bridge is for structure. Further more, 
#           the coupling between the context and strategies is tighter that the coupling between 
#           the abstraction and implementation in the bring pattern.
#
