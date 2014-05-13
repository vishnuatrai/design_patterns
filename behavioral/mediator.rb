#Implementation
#       Define an object that encapsulates how a set of objects interact. Mediator promotes 
#       loose coupling by keeping objects from referring to each other explicitly, and it 
#       lets you vary their interaction independently.
#       a set of objects communicate in well-defined but complex ways. The resulting 
#       interdependencies are unstructured and difficult to understand.
#       reusing an object is difficult because it refers to and communicates with many other objects.
#       a behavior that's distributed between several classes should be customizable 
#       without a lot of subclassing.
#
#Collaborators
#       Mediator::{}
#           defines an interface for communicating with Colleague objects
#       ConcreteMediator::{}
#           knows the colleague classes and keep a reference to the colleague objects
#           implements the communication and transfer the messages between the colleague classes
#       ColleagueClasses::{}
#           keep a reference to its Mediator object
#           communicates with the Mediator whenever it would have otherwise communicated 
#           with another Colleague
#
#Examples
#       GUI Libraries
#       Chat application
#
#Related Patterns
#       design patterns that are closely related to the Mediator pattern 
#       and are often used in conjunction with it
#       Facade Pattern
#           a simplified mediator becomes a facade pattern if the mediator is the only active 
#           class and the colleagues are passive classes. A facade pattern is just an implementation 
#           of the mediator pattern where mediator is the only object triggering and invoking actions 
#           on passive colleague classes. The Facade is being call by some external classes
#       Adapter Pattern
#           the mediator patter just "mediate" the requests between the colleague classes. It is not 
#           supposed to change the messages it receives and sends; if it alters those messages then 
#           it is an Adapter pattern.
#       Observer Pattern
#            the observer and mediator are similar patterns, solving the same problem. The main difference 
#            between them is the problem they address. The observer pattern handles the communication 
#            between observers and subjects or subject. It's very probable to have new observable objects added. 
#            On the other side in the mediator pattern the mediator class is the the most likely class to 
#            be inherited.
