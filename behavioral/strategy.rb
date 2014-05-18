#Implementation
#       Define a family of algorithms, encapsulate each one, and make them interchangeable. 
#       Strategy lets the algorithm vary independently from clients that use it.
#       The Context objects contains a reference to the ConcreteStrategy that should be used. 
#       When an operation is required then the algorithm is run from the strategy object. 
#       The Context is not aware of the strategy implementation. If necessary, addition objects 
#       can be defined to pass data from context object to strategy. 
#       The context object receives requests from the client and delegates them to the strategy object. 
#       Usually the ConcreteStartegy is created by the client and passed to the context. 
#       From this point the clients interacts only with the context.
#       The strategy design pattern splits the behavior (there are many behaviors) of a class 
#       from the class itself. This has some advantages, but the main draw back is that 
#       a client must understand how the Strategies differ. Since clients get exposed to 
#       implementation issues the strategy design pattern should be used only when the variation 
#       in behavior is relevant to them.
#
#Collaborators
#       Strategy::{}
#           defines an interface common to all supported algorithms. 
#           Context uses this interface to call the algorithm defined by a ConcreteStrategy.
#       ConcreteStrategy::{}
#           each concrete strategy implements an algorithm.
#       Context::{}
#           contains a reference to a strategy object
#           may define an interface that lets strategy accessing its data
#       
#Applicability & Examples
#       Robots Application
#
#Specific problems and implementation
#       Passing data to/from Strategy object
#       Families of related algorithms.
#       Optionally Concrete Strategy Objects
#       Strategy and Creational Patterns
#           In the classic implementation of the pattern the client should be aware of 
#           the strategy concrete classes. In order to decouple the client class from strategy 
#           classes is possible to use a factory class inside the context object to create 
#           the strategy object to be used. By doing so the client has only to send a parameter 
#           (like a string) to the context asking to use a specific algorithm, being totally 
#           decoupled of strategy classes.
#       Strategy and Bridge
#           Both of the patterns have the same UML diagram. But they differ in their intent since 
#           the strategy is related with the behavior and bridge is for structure. Further more, 
#           the coupling between the context and strategies is tighter that the coupling between 
#           the abstraction and implementation in the bring pattern.
#
class HTMLFormatter
  def output_report(context)
    puts '<html>'
    puts ' <head>'
    puts " <title>#{context.title}</title>"
    puts ' </head>'
    puts ' <body>'
    context.text.each do |line|
      puts "    <p>#{line}</p>"
    end
    puts '  </body>'
    puts '</html>'
  end
end

class PlainTextFormatter
  def output_report(context)
    puts "***** #{context.title} *****"
    context.text.each do |line|
      puts line
    end
  end
end

class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'Monthly Report'
    @text =  ['Things are going', 'really, really well.']
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(self)
  end
end

report = Report.new(HTMLFormatter.new)
report.output_report

# Change the formatter at runtime
report.formatter = PlainTextFormatter.new
report.output_report

# Using Procs
HTML_FORMATTER = lambda do |context|
  puts '<html>'
  puts ' <head>'
  puts " <title>#{context.title}</title>"
  puts ' </head>'
  puts ' <body>'
  context.text.each do |line|
    puts " <p>#{line}</p>"
  end
  puts ' </body>'
  puts '</html>'
end

PLAIN_TEXT_FORMATTER = lambda do |context|
  puts "***** #{context.title} *****"
  context.text.each do |line|
    puts line
  end
end

class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'Monthly Report'
    @text = ['Things are going', 'really, really well.']
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

report = Report.new(&HTML_FORMATTER)
report.output_report

# Change the formatter at runtime
report.formatter = PLAIN_TEXT_FORMATTER
report.output_report

# For added flexibility, we can use an on-the-fly code block as a formatter
report = Report.new do |context|
  puts("==== on-the-fly formatter 1 ===")
  puts("==== #{context.title} ===")
  context.text.each do |line|
    puts(line)
  end
end
report.output_report


report.formatter = lambda do |context|
  puts("==== on-the-fly formatter 2 ===")
  puts("==== #{context.title} ===")
  context.text.each do |line|
    puts(line)
  end
end
report.output_report

