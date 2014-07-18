#Implementation
#
#   Send the event on a Publish-Subscribe Channel, which delivers a copy of a particular event 
#   to each receiver.
#
#   A Publish-Subscribe Channel works like this: It has one input channel that splits into multiple 
#   output channels, one for each subscriber. When an event is published into the channel, the 
#   Publish-Subscribe Channel delivers a copy of the message to each of the output channels. Each 
#   output channel has only one subscriber, which is only allowed to consume a message once. 
#   In this way, each subscriber only gets the message once and consumed copies disappear from 
#   their channels.
#
#   In software architecture, publish–subscribe is a messaging pattern where senders of messages, 
#   called publishers, do not program the messages to be sent directly to specific receivers, 
#   called subscribers. Instead, published messages are characterized into classes, without knowledge 
#   of what, if any, subscribers there may be. Similarly, subscribers express interest in one or 
#   more classes, and only receive messages that are of interest, without knowledge of what, if any, 
#   publishers there are.
#
#   Publish and Subscribe is a well-established communications paradigm that allows 
#   any number of publishers to communicate with any number of subscribers asynchronously 
#   and anonymously via an event channel.
#   
#   Publish/Subscribe is very powerful in event driven embedded technologies. Suppose a system 
#   has an EventHandler that wants to send out Notification X whenever this event occurs. You have 
#   a priority component, Component A, which is there almost all the time and has to see this message 
#   right away. You also have a bunch of dynamic secondary components (B, C, and D) which may be 
#   there or not. They all have to receive the message sooner or later. Let's look at some possible 
#   scenarios:
#
#   Nothing is very time critical. Publisher sends out Note X to A, B, C, D... ad nauseum. B, C, 
#   and D all begin reacting to X. In the mean time, A gets all panicky and generates event Y. 
#   Notification Y (effectively a Cancel X) goes out to B, C, et al, and these components all roll 
#   their eyes, mutter something about these kids not being able to make up their minds, and toss 
#   the work they did to process the X note. Done.
#
#   Some things are time critical. X goes out as a conditional X. This means that a follow-up 
#   message will come out within a certain maximum time to confirm or cancel the X event. A gets 
#   a chance to chew on the X note and then generate a Confirm or Cancel. B, C, and D can all get 
#   their house in order in case this is the real thing. If they get a Confirm follow-up they 
#   complete the processing of X. Otherwise they get a Cancel and they can drop the whole thing. 
#   That finishes that.
#
#   Time critical and dynamic. The worst case is where A is dynamic as well as the rest of the 
#   subscribers and time is critical. Without A in the picture Note X just goes out to whoever 
#   else is there. When A comes into the picture it has to register with the X event handler. 
#   Then the X handler sends a conditional X notification. The business with the Confirm or Cancel 
#   still applies.
#
#   Advantages:
#       Loose coupling : Publishers are loosely coupled to subscribers, and need not even know of 
#       their existence. With the topic being the focus, publishers and subscribers are allowed to 
#       remain ignorant of system topology. Each can continue to operate normally regardless of the 
#       other. In the traditional tightly coupled client–server paradigm, the client cannot post 
#       messages to the server while the server process is not running, nor can the server receive 
#       messages unless the client is running 
#
#       Scalability: Pub/sub provides the opportunity for better scalability than traditional 
#       client–server, through parallel operation, message caching, tree-based or network-based 
#       routing, etc.
#
#   Disadvantages:
#   Publish and subscribe should be used very carefully. There are some problems in distributed 
#   systems:
#
#     1) Incomplete subscriber list. When you publish, are you publishing to everyone that is supposed 
#     to get the message? This is a system start/failover issue. Different nodes come up at different 
#     times, which means they will register at different times. Data can be lost.
#
#     Solution: For state topics, the current state is (if available) immediately returned upon 
#       subscription, even if there is no immediate publish operation.
#     Solution: For event topics, historical data is kept... possibly limited by age 
#       (e.g. 1 hour), memory limits (e.g. 1 MB), or some combination of the two. Some portion 
#       of this historical data is provided if requested as part of the subscription.
#
#     2) Fast publisher, slow subscriber. Publish is a push technology, which means a chatty 
#     sender can overload the system. This may also cause memory and network problems (drops).
#
#     Solution: Data is published to an intermediate service, which itself subscribes to 
#       the data. Subscribers specify desired minimal recovery period and maximum acceptable 
#       latency (max time by which data may be out-of-date before it is useless, which is 
#       often on the order of minutes for Command+Control to hours for RSS). Messages are 
#       delivered no faster than recovery period, and maximal latencies help set priorities 
#       and allow optimizations and retries. For 'stateful' entities, only the final state is 
#       delivered; for 'event' topics, events delivered in large blocks that are (hopefully) 
#       cheaper to process as a collection than they would be individually.
#     Solution: Publisher may negotiate Subscriber criticality and other factors then 
#       decide how to handle the set of constraints from the collective subscribers. 
#       (Think of modem negotiation, etc.) (Pros: very precise. Cons: a lot of extra protocol work.)
#
#     3) Message order. Message order is often important. If the publisher maintains order, 
#     then how does it deal with a situation where one or more consumers have drops? 
#     The entire cohort will be held back waiting for retransmission.
#
#     Solution: Intermediate service between publisher and receiver to handle this 
#       mess. (DataDistributionService is a reasonable choice.)
#     Solution: Publisher requests SCTP or TCP delivery receipts for all critical messages. 
#       Any Subscriber not returning a delivery receipt within a known time is dropped like a hot rock. 
#       If the Subscriber getting dropped is really important then Publisher issues an error.
#
#   Distributed systems (of any kind, even multiple threads using the same processor but 
#   operating at different dispatch priorities) can have the kinds of problems listed here 
#   (and many more beside). 
#
#
#   Difference between Observer, Pub/Sub, and Data Binding:
#   
#   Data Binding: Essentially, at the core this just means "the value of property X on object Y 
#   is semantically bound to the value of property A on object B. No assumptions are made as to 
#   how Y knows or is fed changes on object B.
#
#   Observer, or Observable/Observer: A design pattern by which an object is imbued with the ability 
#   to notify others of specific events - typically done using actual events, which are kind of like 
#   slots in the object with the shape of a specific function/method. The observable is the one who 
#   provides notifications, and the observer receives those notifications. In .net, the observable 
#   can expose an event and the observer subscribes to that event with an "event handler"shaped hook. 
#   No assumptions are made about the specific mechanism which notifications occur, nor about the 
#   number of observers one observable can notify.
#
#   Pub/Sub: Another name (perhaps with more "broadcast" semantics) of the Observable/Observer 
#   pattern, which usually implies a more "dynamic" flavor - observers can subscribe or unsubscribe 
#   to notifications and one observable can "shout out" to multiple observers. In .net, one can use 
#   the standard events for this, since events are a form of MulticastDelegate, and so can support 
#   delivery of events to multiple subscribers, and also support unsubscription. Pub/sub has a 
#   slightly different meaning in certain contexts, usually involving more "anonymity" between event 
#   and eventer, which can be facilitated by any number of abstractions, usually involving some "middle
#   man" (such as a message queue) who knows all parties, but the individual parties don't know 
#   about each other.
#
#   Observer pattern is mostly implemented in a synchronous way, i.e. the observable calls the 
#   appropriate method of all its observers when some event occurs. The Pub/Sub pattern is mostly 
#   implemented in an asynchronous way (using message queue).
#
#   Also, in the observer pattern, the observers are aware of the observable. Whereas, in Pub/Sub, 
#   neither the publishers, nor the consumers need to know each other. They simply communicate with 
#   the help of message queues.
#
#   As you mentioned correctly, data binding is a generic term and it can be implemented using 
#   either Observer or Pub/Sub method. Data is the observable/publisher.
#
#   Use Observable when you are in the same process and use the Pub/Sub in inter-process scenarios, 
#   where all parties only know the common channel but not the parties.
#
