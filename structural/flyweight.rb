#Implementation
#       The intent of this pattern is to use sharing to support a large number of objects
#       that have part of their internal state in common where the other part of state can vary.#
#Collaborators
#       Flyweight::{}
#           Declares an interface through which flyweights can receive and act on 
#           extrinsic state
#       ConcreteFlyweight::{}
#           Implements the Flyweight interface and stores intrinsic state. 
#           A ConcreteFlyweight object must be sharable. The Concrete flyweight object 
#           must maintain state that it is intrinsic to it, and must be able to 
#           manipulate state that is extrinsic. In the war game example graphical 
#           representation is an intrinsic state, where location and health states 
#           are extrinsic. Soldier moves, the motion behavior manipulates the external 
#           state (location) to create a new location.
#       FlyweightFactory::{}
#           The factory creates and manages flyweight objects. In addition the factory 
#           ensures sharing of the flyweight objects. The factory maintains a pool of 
#           different flyweight objects and returns an object from the pool if it is 
#           already created, adds one to the pool and returns it in case it is new.
#       Client::{}
#           A client maintains references to flyweights in addition to computing 
#           and maintaining extrinsic state
#
#Applicability & Examples
#       The war game
#       Text Editors
#
#Related Patterns
#       Factory and Singleton patterns - Flyweights are usually created using a factory 
#       and the singleton is applied to that factory so that for each type or category 
#       of flyweights a single instance is returned.
#       State and Strategy Patterns - State and Strategy objects are usually implemented 
#       as Flyweights.
#
class FontMetrics
  def initialize(string)
    @string = string
  end

  def [](index)
    glyph_data[@string[index]]
  end

  def glyph_data
    @glyph_data ||= Hash.new { |h,k| h[k] = metrics_for(k) }
  end

  # stubbed out, but would typcially refer to something
  # largish and time consuming to generate
  def metrics_for(k)
    { :bbox => [rand(100), rand(100), rand(100), rand(100)] }
  end
end

string = "Hello World"

metrics = FontMetrics.new(string)

p metrics[0]  #=> {:bbox=>[86, 44, 88, 31]}
p metrics[2]  #=> {:bbox=>[52, 7, 38, 98]}
p metrics[3]  #=> {:bbox=>[52, 7, 38, 98]}
p metrics[-2] #=> {:bbox=>[52, 7, 38, 98]}

p metrics[2].object_id == metrics[3].object_id #=> true

p metrics[0] == metrics[1] #=> false
p metrics[2] == metrics[3] #=> true




