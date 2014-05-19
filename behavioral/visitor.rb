#Implementation
#       Represents an operation to be performed on the elements of an object structure.
#       Visitor lets you define a new operation without changing the classes of 
#       the elements on which it operates.
#
#Collaborators
#       Visitor::{}
#           This is an interface or an abstract class used to declare the visit 
#           operations for all the types of visitable classes. Usually the name 
#           of the operation is the same and the operations are differentiated by 
#           the method signature: The input object type decides which of the method is called.
#       ConcreteVisitor::{}
#           For each type of visitor all the visit methods, declared in abstract 
#           visitor, must be implemented. Each Visitor will be responsible for 
#           different operations. When a new visitor is defined it has to be passed 
#           to the object structure.
#       Visitable::{}
#           is an abstraction which declares the accept operation. This is the entry 
#           point which enables an object to be "visited" by the visitor object. 
#           Each object from a collection should implement this abstraction in order 
#           to be able to be visited.
#       ConcreteVisitable::{}
#           Those classes implements the Visitable interface or class and defines the 
#           accept operation. The visitor object is passed to this object using the 
#           accept operation.
#       ObjectStructure::{}
#           This is a class containing all the objects that can be visited. It offers 
#           a mechanism to iterate through all the elements. This structure is not 
#           necessarily a collection. In can be a complex structure, such as a composite object.
#
class Visitor
  def visit(entry)
  end
end

class ListVisitor < Visitor
  def initialize
    @current_dir = ""
  end

  def visit(entry)
    puts "#{@current_dir}/#{entry}"

    if entry.class == DirectoryEntry
      save_dir = @current_dir
      @current_dir = "#{@current_dir}/#{entry.get_name}"
      directory = entry.get_directory

      directory.each do |e|
        e.accept(self)
      end

      @current_dir = save_dir
    end
  end
end

class FileFindVisitor < Visitor
  def initialize(file_ext)
    @file_ext = file_ext
    @found_files = []
  end

  def visit(entry)
    if entry.class == FileEntry
      file_name = entry.get_name

      if /.*#{@file_ext}$/ =~ file_name
        @found_files << entry
      end
    elsif entry.class == DirectoryEntry
      directory = entry.get_directory

      directory.each do |e|
        e.accept(self)
      end
    end
  end

  def get_found_files
    return @found_files
  end
end


class SizeVisitor < Visitor
  def initialize
    @size = 0
  end

  def visit(entry)
    if entry.class == FileEntry
      @size += entry.get_size
    elsif entry.class == DirectoryEntry
      directory = entry.get_directory

      directory.each do |e|
        e.accept(self)
      end
    end
  end

  def get_size
    return @size
  end
end

class Element
  def accept(visitor)
  end
end


class Entry < Element
  def get_name
  end

  def get_size
  end

  def add(entry)
  end

  def get_directory
  end

  def to_s
    return "#{get_name}(#{get_size})"
  end
end


class FileEntry < Entry
  def initialize(name, size)
    @name = name
    @size = size
  end

  def get_name
    return @name
  end

  def get_size
    return @size
  end

  def accept(visitor)
    visitor.visit(self)
  end
end


class DirectoryEntry < Entry
  def initialize(name)
    @name = name
    @directory = []
  end

  def get_name
    return @name
  end

  def get_size
    visitor = SizeVisitor.new
    visitor.visit(self)

    return visitor.get_size
  end

  def add(entry)
    @directory << entry
    return self
  end

  def get_directory
    return @directory
  end

  def accept(visitor)
    visitor.visit(self)
  end
end

class ElementArrayList
  def initialize
    @list = []
  end

  def add(entry)
    @list << entry
  end

  def accept(visitor)
    @list.each do |entry|
      entry.accept(visitor)
    end
  end
end


puts "Making root entries..."

root_dir = DirectoryEntry.new("root")
bin_dir = DirectoryEntry.new("bin")
tmp_dir = DirectoryEntry.new("tmp")
usr_dir = DirectoryEntry.new("usr")
root_dir.add(bin_dir)
root_dir.add(tmp_dir)
root_dir.add(usr_dir)
bin_dir.add(FileEntry.new("vi", 10000))
bin_dir.add(FileEntry.new("LaTeX", 20000))

puts ""
puts "Making user entries..."

yuki = DirectoryEntry.new("yuki")
hanako = DirectoryEntry.new("hanako")
taro = DirectoryEntry.new("taro")
usr_dir.add(yuki)
usr_dir.add(hanako)
usr_dir.add(taro)
yuki.add(FileEntry.new("diary.html", 1000))
yuki.add(FileEntry.new("logo.png", 1400))
hanako.add(FileEntry.new("kadai.tex", 1355))
taro.add(FileEntry.new("song.mp3", 40000))
taro.add(FileEntry.new("menu.html", 4000))
root_dir.accept(ListVisitor.new)

ffv = FileFindVisitor.new(".html")
root_dir.accept(ffv)

puts ""
puts "HTML files are:"
found_files = ffv.get_found_files

found_files.each do |file|
  puts file
end

puts ""
list = ElementArrayList.new
list.add(root_dir)
list.add(usr_dir)
list.add(taro)
list.accept(ListVisitor.new)

