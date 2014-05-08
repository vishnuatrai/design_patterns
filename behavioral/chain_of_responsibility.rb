#Implementation
#       It avoids attaching the sender of a request to its receiver, giving this way other objects 
#       the possibility of handling the request too.
#       The objects become parts of a chain and the request is sent from one object to another across 
#       the chain until one of the objects will handle it.
#       few situations when using the Chain of Responsibility is more effective:
#       * More than one object can handle a command
#       * The handler is not known in advance
#       * The handler should be determined automatically
#       * It’s wished that the request is addressed to a group of objects without explicitly 
#         specifying its receiver
#       * The group of objects that may handle the command must be specified in a dynamic way  
#
#Collaborators
#       Handler::{}
#           defines an interface for handling requests
#       RequestHandler::{}
#           handles the requests it is responsible for - If it can handle the request it does so, 
#           otherwise it sends the request to its successor
#       Client::{}
#           sends commands to the first object in the chain that may handle the command
#
#Applicability & Examples
#       Software for a system that approves the purchasing requests.
#       Software uses a set of GUI classes where it's needed to propagate GUI events from one object to another
#       In designing a shipping system for electronic orders
#
#
