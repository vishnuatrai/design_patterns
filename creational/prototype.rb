#Implementation 
#     specifying the kind of objects to create using a prototypical instance.
#     creating new objects by copying this prototype.
#
#[Collaborators]
#       Prototype::{Prototype}
#           declares an interface for cloning itself.
#       ConcretePrototype::{ConcretePrototype}
#           implements the operation for cloning itself.
#       Client::{Application}
#           creates a new object by asking a prototype to clone itself.
#
#Use Prototype Pattern when 
#     a system should be independent of how its products are created, 
#     composed, and represented.
#     Classes to be instantiated are specified at run-time.
#     Avoiding the creation of a factory hierarchy is needed.
#     It is more convenient to copy an existing instance than to create a new one.
#

class Prototype  
  def copy
    
  end
end

class ConcretePrototype
  def copy
    prototype = clone

    instance_variables.each do |ivar_name|
      prototype.instance_variable_set( ivar_name,
        instance_variable_get(ivar_name).clone)
    end

    prototype
  end
end

class Application
  def run
    concreate_prototype = ConcretePrototype.new
    concreate_prototype_2 = concreate_prototype.copy
    puts concreate_prototype.inspect
    puts concreate_prototype_2.inspect
  end
end
