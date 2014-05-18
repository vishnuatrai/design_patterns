#Implementation
#       Add additional responsibilities dynamically to an object.
#       The decorator pattern applies when there is a need to dynamically add as well as
#       remove responsibilities to a class, and when subclassing would be impossible 
#       due to the large number of subclasses that could result.
#
#Collaborators
#       Component::{},
#           Interface for objects that can have responsibilities added to them dynamically
#       ConcreteComponent::{}
#           Defines an object to which additional responsibilities can be added
#       Decorator::{}
#           Maintains a reference to a Component object and defines an interface 
#           that conforms to Component's interface
#       ConcreteDecorator::{}
#           Concrete Decorators extend the functionality of the component by adding 
#           state or adding behavior
#
#Applicability & Examples
#       Extending capabilities of a Graphical Window at runtime
#
#Related Patterns
#       Adapter Pattern - A decorator is different from an adapter in that a decorator 
#       changes object's responsibilities, while an adapter changes an object interface.
#       Composite Pattern - A decorator can be viewed as a degenerate composite with 
#       only one component. However, a decorator adds additional responsibilities.
#
class WriterDecorator
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.write_line(line)
  end

  def pos
    @real_writer.pos
  end

  def rewind
    @real_writer.rewind
  end

  def close
    @real_writer.close
  end
end

class EnhancedWriter
  attr_reader :check_sum

  def initialize(path)
    @file = File.open(path, "w")
    @check_sum = 0
    @line_number = 1
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def checksumming_write_line(data)
    data.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
    @check_sum += "\n"[0] % 256
    write_line(data)
  end

  def timestamping_write_line(data)
    write_line("#{Time.new}: #{data}")
  end

  def numbering_write_line(data)
    write_line("#{@line_number}: #{data}")
    @line_number += 1
  end

  def close
    @file.close
  end
end

class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

class CheckSummingWriter < WriterDecorator
  attr_reader :check_sum

  def initialize(real_writer)
    super(real_writer)
    @check_sum = 0
  end

  def write_line(line)
    line.each_byte{ |byte| @check_sum = (@check_sum + byte) % 256 }
    @check_sum += "\n"[0] % 256
    @real_writer.write_line(line)
  end
end

class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number}: #{line}")
    @line_number += 1
  end
end

class TimeStampingWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line("#{Time.new}: #{line}")
  end
end

# Sample 1
w = SimpleWriter.new('final.txt')
class << w
  alias old_write_line write_line

  def write_line(line)
    old_write_line("#{Time.new}: #{line}")
  end
end

w.write_line('write me out')

# Sample 2
module TimeStampingWriter
  def write_line(line)
    super("#{Time.new}: #{line}")
  end
end

module NumberingWriter
  attr_reader :line_number

  def write_line(line)
    @line_number = 1 unless @line_number
    super("#{@line_number}: #{line}")
    @line_number += 1
  end
end

writer = SimpleWriter.new('final.txt')
writer.extend(NumberingWriter)
writer.extend(TimeStampingWriter)

writer.write_line('hello')

