#Implementation
#       Convert the interface of a class into another interface clients expect.
#       Adapter lets classes work together, that could not otherwise because of 
#       incompatible interfaces.
#
#Collaborators
#       Target - defines the domain-specific interface that Client uses.
#       Adapter - adapts the interface Adaptee to the Target interface.
#       Adaptee - defines an existing interface that needs adapting.
#       Client - collaborates with objects conforming to the Target interface.
#
#Applicability & Examples
#       Non Software- Power Supply Adapters, card readers and adapters
#       Software - Wrappers used to adopt 3rd parties libraries and frameworks
#
#Specific problems and implementation
#       Objects Adapters - Based on Delegation : Objects Adapters are the classical 
#       example of the adapter pattern. It uses composition, the Adaptee delegates 
#       the calls to Adaptee (opossed to class adapters which extends the Adaptee). 
#       This behaviour gives us a few advantages over the class adapters(however the 
#       class adapters can be implemented in languages allowing multiple inheritance).
#       The main advantage is that the Adapter adapts not only the Adpatee but all its 
#       subclasses. All it's subclasses with one "small" restriction: all the subclasses 
#       which don't add new methods, because the used mechanism is delegation. So for any
#       new method the Adapter must be changed or extended to expose the new methods as well.
#       The main disadvantage is that it requires to write all the code for delegating 
#       all the necessary requests tot the Adaptee.
#
#       Class Adapters - Based on (Multiple) Inheritance : Class adapters can be implemented 
#       in languages supporting multiple inheritance(PHP does not support 
#       multiple inheritance). Thus, such adapters can not be easy implemented in PHP. 
#       Class adapter uses inheritance instead of composition. It means that instead of 
#       delegating the calls to the Adaptee, it subclasses it. In conclusion it must subclass 
#       both the Target and the Adaptee. 
#       It doesn't require all the code required for delegation, which must be written for 
#       an Object Adapter.
#
class Renderer
  def rendered(text_object)
    text = text_object.text
    size = text_object.size_inches
    color = text_object.color

    # render the text...
    puts 'text object rendered'
  end
end

class TextObject
  attr_reader :text, :size_inches, :color

  def initialize(text, size_inches, color)
    @text = text
    @size_inches = size_inches
    @color = color
  end
end

class BritishTextObject
  attr_reader :string, :size_mm, :colour

  def initialize(string, size_mm, colour)
    @string = string
    @size_mm = size_mm
    @colour = colour
  end
end

# Reopen the class and add some methods to it
# This will effect all instances

class BritishTextObject
  def color
    return colour
  end

  def text
    return string
  end

  def size_inches
    return size_mm / 25.4
  end
end

# Or modify just a single instance
bto = BritishTextObject.new('hello', 50.8, :blue)

class << bto
  def color
    return colour
  end

  def text
    return string
  end

  def size_inches
    return size_mm / 25.4
  end
end

text_object = TextObject.new('hello from TextObject', 40.73, :red)

renderer = Renderer.new
renderer.rendered bto
renderer.rendered text_object


