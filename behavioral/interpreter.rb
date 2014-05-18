#Implementation
#       Given a language, define a representation for its grammar along with an interpreter 
#       that uses the representation to interpret sentences in the language.
#       Map a domain to a language, the language to a grammar, and the grammar to 
#       a hierarchical object-oriented design
#       
#       Interpreter pattern is just the use of the composite pattern applied to represent a grammar. 
#       The Interpreter defines the behaviour while the composite defines only the structure
#
#Applicability & Examples
#       The Interpreter pattern is used exaustively in defining grammars, tokenize input and store it.
#       A specific area where Interpreter can be used are the rules engines
#       The Interpreter pattern can be used to add functionality to the composite pattern
#       Roman Numerals Convertor, Rule Validator, 
#
require 'find'
class Expression

end

class All < Expression
  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
        next unless File.file?(p)
        results << p
    end
    results
  end
end

class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 & result2)
  end
end

class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 + result2).sort.uniq
  end
end

class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

class Bigger < Expression
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if(File.size(p) > @size)
    end
    results
  end
end

class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      name = File.basename(p)
      results << p if File.fnmatch(@pattern, name)
    end
    results
  end
end

class Writable < Expression
  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if(File.writable?(p))
    end
    results
  end
end

class Parser
  def initialize(text)
    @tokens = text.scan(/\(|\)|[\w\.\*]+/)
  end

  def next_token
    @tokens.shift
  end

  def expression
    token = next_token

    if token == nil
      return nil
    elsif token == '('
      result = expression
      raise 'Expected )' unless next_token == ')'
      result

    elsif token == 'all'
      return All.new

    elsif token == 'writable'
      return Writable.new

    elsif token == 'bigger'
      return Bigger.new(next_token.to_i)

    elsif token == 'filename'
      return FileName.new(next_token)  
    
    elsif token == 'not'
      return Not.new(expression)
  
    elsif token == 'and'
      return And.new(expression, expression)

    elsif token == 'or'
      return Or.new(expression, expression)
    
    else
      raise "Unexpected token: #{token}"
        
    end
  end
end

parser = Parser.new("and (and(bigger 1024)(filename *.mp3)) writable")
ast = parser.expression

