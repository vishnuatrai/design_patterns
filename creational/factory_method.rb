# Also known as Virtual Constructor
# Implementation 
#       defines a interface for creating objects, but let subclass to decide which class 
#       to instantiate.
#       refers to the newly created object through a common interface.
# Example - Documents Application
#
# Specific problems and implementation
#      Definition of Creator class - If we apply the pattern to an already written 
#      code there may be problems with the way we have the Creator class already defined. 
#      There are two cases:
#      1) Creator class is abstract and generating method does not have any implementation. 
#      In this case the ConcreteCreator classes must define their own generation method 
#      and this situation usually appears in the cases where the Creator class can't 
#      foresee what ConcreteProduct it will instantiate.
#      2) Creator class is a concrete class, the generating method having a default 
#      implementation. If this happens, the ConcreteCreator classes will use the 
#      generating method for flexibility rather than for generation. The programmer will 
#      always be able to modify the class of the objects that the Creator class implicitly 
#      creates, redefining the generation method.
#
# Drawbacks and Benefits - 
#     1) The main reason for which the factory pattern is used is that it introduces a 
#     separation between the application and a family of classes (it introduces weak 
#     coupling instead of tight coupling hiding concrete classes from the application). 
#     It provides a simple way of extending the family of products with minor changes 
#     in application code.
#     2) It provides customization hooks. When the objects are created directly inside 
#     the class it's hard to replace them by objects which extend their functionality. 
#     If a factory is used instead to create a family of objects the customized objects 
#     can easily replace the original objects, configuring the factory to create them.
#     3) The factory has to be used for a family of objects. If the classes doesn't extend 
#     common base class or interface they can not be used in a factory design template.
#
# [Collaborators]
#     Product:: {Printer}
#     ConcreteProduct::{AsciiPrinter}, {AsciiDraftPrinter}, {PostScriptPrinter}
#     Creator::{Report}
#     FactoryMethod::{Report#get_printer}
#     ConcreteCreator::{DraftReport}, {BasicReport}
#
#
class Printer
  def print_header(header)
    puts(header)
  end
      
  def print_body(body)
    puts(body)
  end

  def print_footer(footer)
    puts(footer)
  end

end

class AsciiPrinter < Printer
end

class AsciiDraftPrinter < AsciiPrinter
  def print_header(header)
  end

  def print_footer(header)
  end

end

class PostScriptPrinter < Printer
end

class PostScriptDraftPrinter < PostScriptPrinter
  def print_header(header)
  end

  def print_footer(header)
  end
end


class Report
  def header()
    "header"
  end

  def body()
    "body"
  end

  def footer()
    "footer"
  end

  def get_printer(type)
    throw "Abstract: Please Overload"
  end

  def print_report(type)
    printer = get_printer(type)
    printer.print_header(header)
    printer.print_body(body)
    printer.print_footer(footer)
  end

end

class DraftReport < Report
  def get_printer(type)
    if (type == "ascii")
      return AsciiDraftPrinter.new()
    elsif (type == "postscript")
      return PostScriptDraftPrinter.new()
    end
  end

end

class BasicReport < Report
  def get_printer(type)
    if (type == "ascii")
      return AsciiPrinter.new()
    elsif (type == "postscript")
      return PostScriptPrinter.new()
    end
  end
end


puts("Draft")
d = DraftReport.new()
d.print_report("ascii")
d.print_report("postscript")
puts("Basic")
b = BasicReport.new()
b.print_report("ascii")
b.print_report("postscript")


