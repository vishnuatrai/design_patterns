# Implementation 
#     reuse and share objects that are expensive to create
#     Reusable - Wraps the limited resource, will be shared by several clients 
#     for a limited amount of time.
#     Client - uses an instance of type Reusable.
#     ReusablePool - manage the reusable objects for use by Clients, creating 
#     and managing a pool of objects.
#     When a client asks for a Reusable object, the pool performs the following actions:
#     1) Search for an available Reusable object and if it was found it will be 
#     returned to the client.
#     2)  If no Reusable object was found then it tries to create a new one. 
#     If this actions succeds the new Reusable object will be returned to the client.
#     3) If the pool was unable to create a new Reusable, the pool will wait until 
#     a reusable object will be released.
#
# Examples - database connections
#
# [Collaborators]
#     Reusable::{}
#     ReusablePool::{}
#     Client::{}

