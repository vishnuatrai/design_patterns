#Implementation
#       Define the skeleton of an algorithm in an operation, deferring some steps to subclasses.
#       Template Method lets subclasses redefine certain steps of an algorithm without letting 
#       them to change the algorithm's structure.
#       to implement the invariant parts of an algorithm once and leave it up to subclasses to 
#       implement the behavior that can vary.
#       when refactoring is performed and common behavior is identified among classes. A abstract 
#       base class containing all the common code (in the template method) should be created to 
#       avoid code duplication.
#
#Collaborators
#       AbstractClass::{}
#           defines abstract primitive operations that concrete subclasses define to implement 
#           steps of an algorithm.
#           implements a template method which defines the skeleton of an algorithm. The template 
#           method calls primitive operations as well as operations defined in AbstractClass or 
#           those of other objects.
#       ConcreteClass::{}
#            implements the primitive operations to carry out subclass-specific steps of the algorithm.
#            When a concrete class is called the template method code will be executed from the base 
#            class while for each method used inside the template method will be called the implementation 
#            from the derived class.
#
#Applicability & Examples
#       Application used by a travel agency
#
#Related Patterns
#       Template Method and Strategy Design Pattern - The strategy pattern is with Template Method pattern. 
#       The difference consists in the fact that Strategy uses delegation while the Template Methods uses 
#       the inheritance.
#
class Report
  def initialize
    @title = 'Monthly Report'
    @text = [ 'Things are going', 'really, really well.']
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_start

  end

  def output_head
    raise 'Called abstract method: output_head'
  end

  def output_body_start

  end

  def output_line(line)
    raise 'Called abstract method: output_line'
  end

  def output_body_end

  end

  def output_end

  end
end

class HTMLReport < Report
  def output_start
    puts('<html>')
  end

  def output_head
    puts(' <head>')
    puts(" <title>#{@title}</title>")
    puts('   </head>')
  end

  def output_body_start
    puts(' <body>')
  end

  def output_line(line)
    puts (" <p>#{line}</p>")
  end

  def output_body_end
    puts(' </body>')
  end

  def output_end
    puts('</html>')
  end
end

class PlainTextReport < Report
  def output_head
    puts("*** #{@title} ***") 
  end

  def output_line(line)
    puts line
  end
end

report = HTMLReport.new
report.output_report

report = PlainTextReport.new
report.output_report

