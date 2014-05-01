# Should be used when only one instance of class is required
# Implementation should ensure only one instance of class is created.
# Implementation should provide a global point of access to the class
# Example - Logger, 
#           Configuration, 
#           Accessing resources in shared mode, 
#           Factories with singleton : If we design factory class that will generate objects with their ids and if 
# two or more threads are generating objects then singleton implementation will avoid overlaping(duplicate) ids.
#
class Configuration 
  attr_reader :config

  def initialize()
    @config = {}
  end

  @@instance = self.new

  def self.instance
    return @@instance
  end
  
  def read(key)
    @config[key]
  end

  def write(key,val)
    @config[key] = val
  end

  private_class_method :new

end

Configuration.instance.write(:name, 'vishnu')
Configuration.instance.read(:name)


