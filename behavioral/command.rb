#Implementation
#       encapsulate a request in an object
#       allows the parameterization of clients with different requests
#       allows saving the requests in a queue
#       The Client asks for a command to be executed. The Invoker takes the command, 
#       encapsulates it and places it in a queue, in case there is something else to do first, 
#       and the ConcreteCommand that is in charge of the requested command, 
#       sending its result to the Receiver.
#
#Collaborators
#       Command::{}
#           declares an interface for executing an operation
#       ConcreteCommand::{}
#           extends the Command interface, implementing the Execute method by invoking the corresponding 
#           operations on Receiver. It defines a link between the Receiver and the action
#       Client::{}
#           creates a ConcreteCommand object and sets its receiver
#       Invoker::{}
#           asks the command to carry out the request
#       Receiver::{}
#           knows how to perform the operations
#
#Applicability & Examples
#       parameterizes objects depending on the action they must perform
#       specifies or adds in a queue and executes requests at different moments in time
#       offers support for undoable actions
#       structures the system in high level operations that based on primitive operations
#       decouples the object that invokes the action from the object that performs the action
#

