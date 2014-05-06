#Implementation
#       The intent of this pattern is to compose objects into tree structures 
#       to represent part-whole hierarchies.
#       Composite lets clients treat individual objects and compositions of 
#       objects uniformly.
#       The composite pattern applies when there is a part-whole hierarchy of objects 
#       and a client needs to deal with objects uniformly regardless of the fact that 
#       an object might be a leaf or a branch. 
#
#Collaborators
#       Component::{}
#           Component is the abstraction for leafs and composites. It defines the 
#           interface that must be implemented by the objects in the composition. 
#           For example a file system resource defines move, copy, rename, and 
#           getSize methods for files and folders.
#       Leaf::{}
#           Leafs are objects that have no children. They implement services described 
#           by the Component interface. For example a file object implements move, copy, 
#           rename, as well as getSize methods which are related to the Component interface.
#       Composite::{}
#           A Composite stores child components in addition to implementing methods defined 
#           by the component interface. Composites implement methods defined in the 
#           Component interface by delegating to child components. In addition composites 
#           provide additional methods for adding, removing, as well as getting components.
#       Client::{}
#           The client manipulates objects in the hierarchy using the component interface.
#
#Applicability & Examples
#       Graphics Drawing Editor
#       File System Implementation
#
#Related Patterns
#       Decorator Pattern - Decorator is often used with Composite. When decorators 
#       and composites are used together, they will usually have a common parent class. 
#       So decorators will have to support the Component interface with operations like 
#       Add, Remove, and GetChild.
#
