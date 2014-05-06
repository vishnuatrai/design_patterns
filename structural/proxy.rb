#Implementation
#       provide a "Placeholder" for an object to control references to it.
#       A client obtains a reference to a Proxy, the client then handles the proxy 
#       in the same way it handles RealSubject and thus invoking the method 
#       doSomething(). At that point the proxy can do different things prior to 
#       invoking RealSubject�s doSomething() method. The client might create 
#       a RealSubject object at that point, perform initialization, check permissions 
#       of the client to invoke the method, and then invoke the method on the object. 
#       The client can also do additional tasks after invoking the doSomething() method, 
#       such as incrementing the number of references to the object.
#
#Collaborators
#       Subject::{}
#           Interface implemented by the RealSubject and representing its services. 
#           The interface must be implemented by the proxy as well so that the proxy 
#           can be used in any location where the RealSubject can be used.
#       Proxy::{}
#           Maintains a reference that allows the Proxy to access the RealSubject.
#           Implements the same interface implemented by the RealSubject so that the 
#           Proxy can be substituted for the RealSubject.
#           Controls access to the RealSubject and may be responsible for its 
#           creation and deletion.
#           Other responsibilities depend on the kind of proxy.
#       RealSubject::{}
#           The real object that the proxy represents.
#
#Applicability & Examples
#       Virtual Proxy 
#       Security Proxies
#
#Related Patterns
#       Adapter Design Pattern - The adapter implements a different interface to the 
#       object it adapts where a proxy implements the same interface as its subject.
#       Decorator Design Pattern - A decorator implementation can be the same as 
#       the proxy however a decorator adds responsibilities to an object while a proxy 
#       controls access to it.
#
#
