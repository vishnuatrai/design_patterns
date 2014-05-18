#Implementation
#       encapsulate a request in an object
#       allows the parameterization of clients with different requests
#       allows saving the requests in a queue
#       The Client asks for a command to be executed. The Invoker takes the command, 
#       encapsulates it and places it in a queue, in case there is something else to do first, 
#       and the ConcreteCommand that is in charge of the requested command, 
#       sending its result to the Receiver.
#
#Collaborators
#       Command::{}
#           declares an interface for executing an operation
#       ConcreteCommand::{}
#           extends the Command interface, implementing the Execute method by invoking the corresponding 
#           operations on Receiver. It defines a link between the Receiver and the action
#       Client::{}
#           creates a ConcreteCommand object and sets its receiver
#       Invoker::{}
#           asks the command to carry out the request
#       Receiver::{}
#           knows how to perform the operations
#
#Applicability & Examples
#       parameterizes objects depending on the action they must perform
#       specifies or adds in a queue and executes requests at different moments in time
#       offers support for undoable actions
#       structures the system in high level operations that based on primitive operations
#       decouples the object that invokes the action from the object that performs the action
#
class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute
  end
end

class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each { |cmd| cmd.execute }
  end

  def unexecute
    @commands.reverse.each { |cmd| cmd.unexecute }
  end

  def description
    description = ''
    @commands.each { |cmd| description += cmd.description + "\n" }
    description
  end
end

require 'FileUtils'
class CopyFile < Command
  def initialize(source, target)
    super "Copy file: #{source} to #{target}"
    @source = source
    @target = target
  end

  def execute
    if File.exists?(@target)
      @contents = File.read(@target)
    end
    FileUtils.copy(@source, @target)
  end

  def unexecute
    if @contents
      f = File.open(@target,'w')
      f.write(@contents)
      f.close
    else
      File.delete(@target)
    end
  end
end

class CreateFile < Command
  def initialize(path, contents)
    super "Create file: #{path}" 
    @path = path
    @contents = contents
  end

  def execute
    f = File.open(@path, 'w')
    f.write @contents
    f.close
  end

  def unexecute
    File.delete(@path)
  end
end

class DeleteFile < Command
  def initialize(path)
    super "Delete file: #{path}"
    @path = path
  end

  def execute
    if File.exists?(@path)
      @contents = File.read(@path)
    end
    File.delete(@path)
  end

  def unexecute
    if @contents
      f = File.open(@path,'w')
      f.write(@contents)
      f.close
    end
  end
end

cmds = CompositeCommand.new
cmds.add_command CreateFile.new('file1.txt', "hello world\n")
cmds.add_command CopyFile.new('file1.txt', 'file2.txt')
cmds.add_command DeleteFile.new('file1.txt')

puts cmds.description
cmds.execute

sleep 1.5
cmds.unexecute

