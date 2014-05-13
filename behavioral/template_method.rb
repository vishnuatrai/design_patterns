#Implementation
#       Define the skeleton of an algorithm in an operation, deferring some steps to subclasses.
#       Template Method lets subclasses redefine certain steps of an algorithm without letting 
#       them to change the algorithm's structure.
#       to implement the invariant parts of an algorithm once and leave it up to subclasses to 
#       implement the behavior that can vary.
#       when refactoring is performed and common behavior is identified among classes. A abstract 
#       base class containing all the common code (in the template method) should be created to 
#       avoid code duplication.
#
#Collaborators
#       AbstractClass::{}
#           defines abstract primitive operations that concrete subclasses define to implement 
#           steps of an algorithm.
#           implements a template method which defines the skeleton of an algorithm. The template 
#           method calls primitive operations as well as operations defined in AbstractClass or 
#           those of other objects.
#       ConcreteClass::{}
#            implements the primitive operations to carry out subclass-specific steps of the algorithm.
#            When a concrete class is called the template method code will be executed from the base 
#            class while for each method used inside the template method will be called the implementation 
#            from the derived class.
#
#Applicability & Examples
#       Application used by a travel agency
#
#Related Patterns
#       Template Method and Strategy Design Pattern - The strategy pattern is with Template Method pattern. 
#       The difference consists in the fact that Strategy uses delegation while the Template Methods uses 
#       the inheritance.
#
