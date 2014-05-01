# Factory pattern implementation should create objects without exposing the instanciation logic to the client
# Implementaion should refers to the newly created object through a comman interface.
#
#

class CommandFactory
  def initialize(context)
    @context = context
  end

  def create_command(name)
    if (name == "Paste")
      return PasteCommand.new(@context)
    elsif (name == "Cut")
      return CutCommand.new(@context)
    else
      throw ("Could Not Construct "+name)
    end  
  end
           
end


class PasteCommand
  def initialize(context)

  end
end

class CutCommand
  def initialize(context)

  end
end
