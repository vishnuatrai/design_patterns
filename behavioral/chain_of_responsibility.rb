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
module Chainable
  def next_in_chain(link)
    @next = link
  end

  def method_missing(method, *args, &block)
    if @next == nil
      puts "This request cannot be handled!"
      return
    end
    @next.__send__(method, *args, &block)
  end
end

class WebManager
  include Chainable

  def initialize(link = nil)
    next_in_chain(link)
  end
       
  def deliver_application
    design_interface
    build_application
    write_documentation
    deploy_application
    puts "#{self.class.to_s}: Application delivered"
  end
end

class WebDeveloper
  include Chainable

  def initialize(link = nil)
    next_in_chain(link)
  end

  def build_application
    puts "#{self.class.to_s}: I'm building the application"
  end

  def deploy_application
    puts "#{self.class.to_s}: I'm deploying the application"
  end
end

class WebDesigner
  include Chainable

  def initialize(link = nil)
    next_in_chain(link)
  end

  def design_interface
    puts "#{self.class.to_s}: I'm designing the interface"
  end
end

class TechnicalWriter
  include Chainable

  def initialize(link = nil)
    next_in_chain(link)
  end

  def write_documentation
    puts "#{self.class.to_s}: I'm writing the documentation"
  end
end

provider = WebManager.new(WebDeveloper.new(WebDesigner.new(TechnicalWriter.new)))
provider.deliver_application
provider.make_support
