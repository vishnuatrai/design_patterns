#Implementation
#       Provide a way to access the elements of an aggregate object sequentially without 
#       exposing its underlying representation.
#       The abstraction provided by the iterator pattern allows you to modify the collection 
#       implementation without making any changes outside of collection
#       access contents of a collection without exposing its internal structure.
#       support multiple simultaneous traversals of a collection.
#       provide a uniform interface for traversing different collection.
#
#Collaborators
#       IIterator::{}
#           This interface represent the AbstractIterator, defining the iterator
#       ProductIterator::{}
#           This is the implementation of Iterator(implements the IIterator interface)
#       IContainer::{}
#           This is an interface defining the Agregate
#       ProductsCollection::{}
#           An implementation of the collection
#
#Specific problems and implementation
#       Iterator and multithreading
#       External vs. internal iterators
#       Who defines the traversal algorithm?
#           
